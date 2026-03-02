import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/app_constants.dart';

class RemoteConfigService {
  RemoteConfigService(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> initialize() async {
    await _remoteConfig.setDefaults(<String, Object>{
      kPassFailEnabledKey: false,
    });

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    try {
      await _remoteConfig.fetchAndActivate();
    } catch (_) {
      // Keep defaults when fetch fails.
    }
  }

  bool get passFailEnabled => _remoteConfig.getBool(kPassFailEnabledKey);

  Future<void> refresh() async {
    await _remoteConfig.fetchAndActivate();
  }
}

final RemoteConfigService remoteConfigService = RemoteConfigService(
  FirebaseRemoteConfig.instance,
);

final remoteConfigServiceProvider = Provider<RemoteConfigService>(
  (Ref ref) => remoteConfigService,
);
