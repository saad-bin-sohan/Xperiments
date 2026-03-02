import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/app_strings.dart';
import 'package:mobile/core/theme/theme_mode_controller.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/profile/domain/entities/user_preferences.dart';
import 'package:mobile/features/profile/presentation/controllers/profile_controller.dart';
import 'package:mobile/features/profile/presentation/providers/profile_providers.dart';
import 'package:mobile/features/profile/presentation/widgets/settings_section.dart';

class ProfileSettingsScreen extends ConsumerStatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  ConsumerState<ProfileSettingsScreen> createState() {
    return _ProfileSettingsScreenState();
  }
}

class _ProfileSettingsScreenState extends ConsumerState<ProfileSettingsScreen> {
  late final TextEditingController _friendEmailController;

  @override
  void initState() {
    super.initState();
    _friendEmailController = TextEditingController();
  }

  @override
  void dispose() {
    _friendEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(profileControllerProvider, (_, next) {
      next.whenOrNull(
        error: (Object error, StackTrace stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final authAsync = ref.watch(authSessionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: authAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) {
          return Center(child: Text(error.toString()));
        },
        data: (session) {
          final user = session.user;
          if (user == null) {
            return const AppEmptyState(
              title: 'Sign in required',
              message: 'Authenticate to access your settings.',
              icon: Icons.lock_outline,
            );
          }

          final preferencesAsync = ref.watch(currentUserPreferencesProvider);
          return AppAsyncView<UserPreferences>(
            value: preferencesAsync,
            data: (preferences) {
              return _ProfileContent(
                userName: user.displayName,
                userEmail: user.email,
                photoUrl: user.photoUrl,
                preferences: preferences,
                friendEmailController: _friendEmailController,
              );
            },
          );
        },
      ),
    );
  }
}

class _ProfileContent extends ConsumerWidget {
  const _ProfileContent({
    required this.userName,
    required this.userEmail,
    required this.photoUrl,
    required this.preferences,
    required this.friendEmailController,
  });

  final String userName;
  final String userEmail;
  final String? photoUrl;
  final UserPreferences preferences;
  final TextEditingController friendEmailController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(profileControllerProvider.notifier);
    final isBusy = ref.watch(profileControllerProvider).isLoading;
    final passFailEnabled = ref.watch(passFailEnabledProvider);
    final themeModeAsync = ref.watch(themeModeControllerProvider);

    final currentTheme = themeModeAsync.asData?.value ?? ThemeMode.system;

    return ListView(
      padding: const EdgeInsets.all(AppSizes.spacingMd),
      children: <Widget>[
        SettingsSection(
          title: 'Account',
          children: <Widget>[
            Row(
              children: <Widget>[
                _Avatar(name: userName, photoUrl: photoUrl),
                const SizedBox(width: AppSizes.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(userEmail),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingMd),
            FilledButton.tonal(
              onPressed: isBusy ? null : controller.signOut,
              child: const Text('Sign out'),
            ),
            const SizedBox(height: AppSizes.spacingSm),
            OutlinedButton(
              onPressed: isBusy
                  ? null
                  : () async {
                      final confirmed = await _confirmDeleteAccount(context);
                      if (confirmed && context.mounted) {
                        await controller.deleteAccount();
                      }
                    },
              child: const Text('Delete account'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingMd),
        SettingsSection(
          title: 'Preferences',
          children: <Widget>[
            DropdownButtonFormField<ThemeMode>(
              initialValue: currentTheme,
              decoration: const InputDecoration(labelText: 'Theme'),
              items: const <DropdownMenuItem<ThemeMode>>[
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: isBusy
                  ? null
                  : (ThemeMode? value) {
                      if (value != null) {
                        ref
                            .read(themeModeControllerProvider.notifier)
                            .setThemeMode(value);
                      }
                    },
            ),
            const SizedBox(height: AppSizes.spacingSm),
            SwitchListTile.adaptive(
              value: preferences.notificationsEnabled,
              title: const Text('Notifications'),
              onChanged: isBusy
                  ? null
                  : (bool value) {
                      controller.updatePreferences(
                        UserPreferencesPatch(notificationsEnabled: value),
                      );
                    },
            ),
            SwitchListTile.adaptive(
              value: preferences.nudgeDaysThreshold > 0,
              title: const Text('Gentle nudge reminder'),
              subtitle: Text('${preferences.nudgeDaysThreshold} day threshold'),
              onChanged: isBusy
                  ? null
                  : (bool value) {
                      controller.updatePreferences(
                        UserPreferencesPatch(
                          nudgeDaysThreshold: value
                              ? preferences.nudgeDaysThreshold
                              : 0,
                        ),
                      );
                    },
            ),
            if (preferences.nudgeDaysThreshold > 0)
              Slider(
                value: preferences.nudgeDaysThreshold.toDouble().clamp(1, 30),
                min: 1,
                max: 30,
                divisions: 29,
                label: '${preferences.nudgeDaysThreshold} days',
                onChanged: isBusy
                    ? null
                    : (double value) {
                        controller.updatePreferences(
                          UserPreferencesPatch(
                            nudgeDaysThreshold: value.round(),
                          ),
                        );
                      },
              ),
            SwitchListTile.adaptive(
              value: preferences.friendAccountabilityEnabled,
              title: const Text('Friend accountability notifications'),
              // TODO: Wire notification delivery in Phase 4 (FCM + Functions).
              onChanged: isBusy
                  ? null
                  : (bool value) {
                      controller.updatePreferences(
                        UserPreferencesPatch(
                          friendAccountabilityEnabled: value,
                        ),
                      );
                    },
            ),
            if (preferences.friendAccountabilityEnabled) ...<Widget>[
              Wrap(
                spacing: AppSizes.spacingXs,
                children: preferences.friendEmails
                    .map(
                      (String email) => InputChip(
                        label: Text(email),
                        onDeleted: isBusy
                            ? null
                            : () {
                                final updated = List<String>.from(
                                  preferences.friendEmails,
                                )..remove(email);
                                controller.updatePreferences(
                                  UserPreferencesPatch(friendEmails: updated),
                                );
                              },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppSizes.spacingSm),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: friendEmailController,
                      decoration: const InputDecoration(
                        labelText: 'Friend email',
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacingSm),
                  FilledButton.tonal(
                    onPressed: isBusy
                        ? null
                        : () {
                            final email = friendEmailController.text.trim();
                            if (email.isEmpty) {
                              return;
                            }
                            final updated = List<String>.from(
                              preferences.friendEmails,
                            );
                            if (!updated.contains(email)) {
                              updated.add(email);
                              controller.updatePreferences(
                                UserPreferencesPatch(friendEmails: updated),
                              );
                            }
                            friendEmailController.clear();
                          },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSizes.spacingMd),
        SettingsSection(
          title: 'Optional Features',
          children: <Widget>[
            SwitchListTile.adaptive(
              value: preferences.journalEnabled,
              title: const Text('Standalone Journal'),
              // TODO: Render standalone journal inside each lab screen in Phase 4.
              onChanged: isBusy
                  ? null
                  : (bool value) {
                      controller.updatePreferences(
                        UserPreferencesPatch(journalEnabled: value),
                      );
                    },
            ),
            SwitchListTile.adaptive(
              value: preferences.interferenceLogEnabled,
              title: const Text('Experiment Interference Log'),
              onChanged: isBusy
                  ? null
                  : (bool value) {
                      controller.updatePreferences(
                        UserPreferencesPatch(interferenceLogEnabled: value),
                      );
                    },
            ),
            if (passFailEnabled)
              SwitchListTile.adaptive(
                value: preferences.passFailUiEnabled,
                title: const Text('Pass/Fail on experiments'),
                onChanged: isBusy
                    ? null
                    : (bool value) {
                        controller.updatePreferences(
                          UserPreferencesPatch(passFailUiEnabled: value),
                        );
                      },
              ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingMd),
        SettingsSection(
          title: 'Data',
          children: <Widget>[
            FilledButton.tonal(
              onPressed: () {
                // TODO: Implement monthly summary computation in Phase 3.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Monthly summary will be available in Phase 3.',
                    ),
                  ),
                );
              },
              child: const Text('View This Month'),
            ),
            const SizedBox(height: AppSizes.spacingSm),
            FilledButton.tonal(
              onPressed: () {
                // TODO: Implement yearly summary computation in Phase 3.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Yearly summary will be available in Phase 3.',
                    ),
                  ),
                );
              },
              child: const Text('View This Year'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingLg),
      ],
    );
  }

  Future<bool> _confirmDeleteAccount(BuildContext context) async {
    final TextEditingController confirmController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(AppStrings.deleteAccountConfirmation),
              const SizedBox(height: AppSizes.spacingSm),
              TextField(
                controller: confirmController,
                decoration: const InputDecoration(
                  labelText: 'Type DELETE to confirm',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pop(confirmController.text.trim() == 'DELETE');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    confirmController.dispose();
    return confirmed ?? false;
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name, required this.photoUrl});

  final String name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null && photoUrl!.isNotEmpty) {
      return CircleAvatar(radius: 24, backgroundImage: NetworkImage(photoUrl!));
    }

    final initial = name.isNotEmpty ? name.characters.first.toUpperCase() : '?';

    return CircleAvatar(radius: 24, child: Text(initial));
  }
}
