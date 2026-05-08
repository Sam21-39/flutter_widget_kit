import 'exceptions.dart';

/// Static facade for interacting with OS Widget systems.
class WidgetKit {
  WidgetKit._();

  /// Updates the state of a specific widget.
  ///
  /// [widgetId] matches the ID in `@WidgetDefinition`.
  /// [state] must be a JSON-serializable object.
  static Future<void> update(String widgetId, dynamic state) async {
    try {
      // Implementation will bridge to native code.
    } catch (e) {
      throw WidgetUpdateException(
        'Failed to update widget $widgetId',
        widgetId: widgetId,
        cause: e,
      );
    }
  }

  /// Schedules a periodic update for a widget.
  static Future<void> schedulePeriodicUpdate(
    String widgetId,
    Duration interval,
  ) async {
    if (interval.inMinutes < 15) {
      throw SchedulingException(
        'Update interval must be at least 15 minutes',
        widgetId: widgetId,
      );
    }
    // Implementation...
  }

  /// Cancels any scheduled updates for a widget.
  static Future<void> cancelScheduledUpdate(String widgetId) async {
    // Implementation...
  }

  /// Reloads all registered widgets.
  static Future<void> reloadAll() async {
    // Implementation...
  }

  /// Starts a new Live Activity (iOS only).
  static Future<String> startLiveActivity(
    String activityType,
    dynamic initialState,
  ) async {
    try {
      // Implementation...
      return 'activity-id';
    } catch (e) {
      throw LiveActivityException(
        'Failed to start live activity $activityType',
        cause: e,
      );
    }
  }

  /// Updates an active Live Activity.
  static Future<void> updateLiveActivity(
    String activityId,
    dynamic updatedState,
  ) async {
    // Implementation...
  }

  /// Ends a Live Activity.
  static Future<void> endLiveActivity(
    String activityId,
    EndReason reason,
  ) async {
    // Implementation...
  }
}

/// Reasons for ending a Live Activity.
enum EndReason {
  /// The activity completed normally.
  dismissed,

  /// The activity was cancelled by the user.
  cancelled,

  /// The activity timed out or expired.
  expired,
}
