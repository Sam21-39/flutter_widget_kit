import 'package:flutter/foundation.dart';

/// Manages JSON serialization to App Groups (iOS) and SharedPreferences (Android).
abstract class WidgetStateManager {
  /// Saves the [state] for a given [key].
  Future<void> save(String key, Map<String, dynamic> state);

  /// Loads the state for a given [key].
  Future<Map<String, dynamic>?> load(String key);

  /// Deletes the state for a given [key].
  Future<void> delete(String key);

  /// Clears all stored widget states.
  Future<void> clear();

  /// Platform-adaptive factory constructor.
  factory WidgetStateManager.forPlatform() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _IOSWidgetStateManager();
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return _AndroidWidgetStateManager();
    }
    throw UnsupportedError(
        'WidgetStateManager is only supported on iOS and Android.');
  }
}

class _IOSWidgetStateManager implements WidgetStateManager {
  @override
  Future<void> clear() async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<Map<String, dynamic>?> load(String key) async => null;

  @override
  Future<void> save(String key, Map<String, dynamic> state) async {}
}

class _AndroidWidgetStateManager implements WidgetStateManager {
  @override
  Future<void> clear() async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<Map<String, dynamic>?> load(String key) async => null;

  @override
  Future<void> save(String key, Map<String, dynamic> state) async {}
}
