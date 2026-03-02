import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/profile/domain/entities/user_preferences.dart';
import 'package:mobile/features/profile/presentation/providers/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_controller.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  FutureOr<ThemeMode> build() async {
    final session = ref.watch(authSessionProvider).asData?.value;
    if (session == null || !session.isAuthenticated || session.user == null) {
      return ThemeMode.system;
    }

    final preferences = await ref.watch(currentUserPreferencesProvider.future);
    return _toThemeMode(preferences.theme);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final session = ref.read(authSessionProvider).asData?.value;
    if (session == null || session.user == null) {
      state = const AsyncData(ThemeMode.system);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userId = session.user!.id;
      final updatePreferences = ref.read(updatePreferencesUseCaseProvider);
      await updatePreferences.call(
        userId: userId,
        patch: UserPreferencesPatch(theme: mode.toPreference()),
      );
      return mode;
    });
  }

  ThemeMode _toThemeMode(AppThemePreference preference) {
    switch (preference) {
      case AppThemePreference.system:
        return ThemeMode.system;
      case AppThemePreference.light:
        return ThemeMode.light;
      case AppThemePreference.dark:
        return ThemeMode.dark;
    }
  }
}

extension on ThemeMode {
  AppThemePreference toPreference() {
    switch (this) {
      case ThemeMode.system:
        return AppThemePreference.system;
      case ThemeMode.light:
        return AppThemePreference.light;
      case ThemeMode.dark:
        return AppThemePreference.dark;
    }
  }
}
