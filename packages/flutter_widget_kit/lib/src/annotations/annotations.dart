import 'package:meta/meta_meta.dart';

/// Strategy for handling widget placeholders when state is not yet available.
enum PlaceholderStrategy {
  /// Show a skeleton/shimmer UI.
  skeleton,

  /// Show the last known good state.
  lastKnownState,

  /// Hide the widget entirely (if supported by OS).
  hidden,
}

/// Base class for widget update strategies.
abstract class UpdateStrategy {
  const UpdateStrategy();
}

/// Update strategy that refreshes the widget at a periodic interval.
class PeriodicUpdate extends UpdateStrategy {
  /// The refresh interval. Minimum 15 minutes enforced by OS.
  final Duration interval;

  /// Whether the update requires a network connection.
  final bool requiresNetwork;

  /// Whether the update requires the device to be charging.
  final bool requiresCharging;

  /// Whether the update requires an unmetered (Wi-Fi) network.
  final bool requiresUnmeteredNetwork;

  const PeriodicUpdate({
    required this.interval,
    this.requiresNetwork = false,
    this.requiresCharging = false,
    this.requiresUnmeteredNetwork = false,
  });
}

/// Update strategy that triggers via push notifications (FCM/APNs).
class PushUpdate extends UpdateStrategy {
  /// The FCM topic to subscribe to for updates.
  final String? fcmTopic;

  /// The APNs topic for ActivityKit updates.
  final String? apnsTopic;

  const PushUpdate({
    this.fcmTopic,
    this.apnsTopic,
  });
}

/// Update strategy that only refreshes when explicitly called from Dart.
class ManualUpdate extends UpdateStrategy {
  const ManualUpdate();
}

/// Annotation for defining a Home Screen Widget.
///
/// Applied to a class that is also annotated with `@freezed`.
@Target({TargetKind.class})
class WidgetDefinition {
  /// Unique identifier for the widget.
  final String widgetId;

  /// App Group ID for sharing data between App and Widget (iOS only).
  final String appGroupId;

  /// Android namespace for the generated receiver.
  final String androidNamespace;

  /// Localized name of the widget shown in the gallery.
  final String displayName;

  /// Localized description of the widget.
  final String description;

  /// Supported widget sizes/families.
  final List<dynamic> supportedFamilies;

  /// Strategy for handling missing state.
  final PlaceholderStrategy placeholderStrategy;

  /// Whether to generate Xcode preview support.
  final bool previewable;

  /// How the widget state is updated.
  final UpdateStrategy updateStrategy;

  const WidgetDefinition({
    required this.widgetId,
    required this.appGroupId,
    required this.androidNamespace,
    required this.displayName,
    required this.description,
    this.supportedFamilies = const [],
    this.placeholderStrategy = PlaceholderStrategy.skeleton,
    this.previewable = true,
    this.updateStrategy = const ManualUpdate(),
  });
}

/// Annotation for defining a Live Activity (iOS only).
///
/// Applied to a Freezed class.
@Target({TargetKind.class})
class LiveActivity {
  /// Unique type identifier for the activity.
  final String activityType;

  /// Whether to support Live Activities.
  final bool supportsLiveActivities;

  /// Whether to support Dynamic Island views.
  final bool supportsDynamicIsland;

  const LiveActivity({
    required this.activityType,
    this.supportsLiveActivities = true,
    this.supportsDynamicIsland = true,
  });
}
