import 'package:flutter/material.dart';
import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/core/firebase/remote_config_service.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/profile/data/datasources/preferences_remote_data_source.dart';
import 'package:mobile/features/profile/data/repositories/preferences_repository_impl.dart';
import 'package:mobile/features/profile/domain/entities/user_preferences.dart';
import 'package:mobile/features/profile/domain/repositories/preferences_repository.dart';
import 'package:mobile/features/profile/domain/usecases/update_preferences.dart';
import 'package:mobile/features/profile/domain/usecases/watch_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_providers.g.dart';

@Riverpod(keepAlive: true)
PreferencesRemoteDataSource preferencesRemoteDataSource(Ref ref) {
  return PreferencesRemoteDataSource(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
PreferencesRepository preferencesRepository(Ref ref) {
  return PreferencesRepositoryImpl(
    ref.watch(preferencesRemoteDataSourceProvider),
  );
}

@Riverpod(keepAlive: true)
WatchPreferences watchPreferencesUseCase(Ref ref) {
  return WatchPreferences(ref.watch(preferencesRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdatePreferences updatePreferencesUseCase(Ref ref) {
  return UpdatePreferences(ref.watch(preferencesRepositoryProvider));
}

@riverpod
Stream<UserPreferences> currentUserPreferences(Ref ref) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Stream<UserPreferences>.value(const UserPreferences());
  }

  return ref.watch(watchPreferencesUseCaseProvider).call(user.id);
}

@riverpod
bool passFailEnabled(Ref ref) {
  return ref.watch(remoteConfigServiceProvider).passFailEnabled;
}

@riverpod
ThemeMode currentThemeMode(Ref ref) {
  final preference = ref
      .watch(currentUserPreferencesProvider)
      .asData
      ?.value
      .theme;
  switch (preference) {
    case AppThemePreference.light:
      return ThemeMode.light;
    case AppThemePreference.dark:
      return ThemeMode.dark;
    case AppThemePreference.system:
    case null:
      return ThemeMode.system;
  }
}
