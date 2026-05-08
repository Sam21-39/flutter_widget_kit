/// Base class for all flutter_widget_kit exceptions.
abstract class WidgetKitException implements Exception {
  final String message;
  final String? widgetId;
  final Object? cause;

  const WidgetKitException(this.message, {this.widgetId, this.cause});

  @override
  String toString() {
    final base = 'WidgetKitException: $message';
    final idStr = widgetId != null ? ' (Widget: $widgetId)' : '';
    final causeStr = cause != null ? '\nCause: $cause' : '';
    return '$base$idStr$causeStr';
  }
}

/// Thrown when a widget update fails.
class WidgetUpdateException extends WidgetKitException {
  const WidgetUpdateException(super.message, {super.widgetId, super.cause});
}

/// Thrown when platform configuration is missing or incorrect.
class PlatformConfigException extends WidgetKitException {
  const PlatformConfigException(super.message, {super.widgetId, super.cause});
}

/// Thrown when state serialization fails.
class StateSerializationException extends WidgetKitException {
  const StateSerializationException(super.message,
      {super.widgetId, super.cause});
}

/// Thrown when scheduling a periodic update fails.
class SchedulingException extends WidgetKitException {
  const SchedulingException(super.message, {super.widgetId, super.cause});
}

/// Thrown when a Live Activity operation fails.
class LiveActivityException extends WidgetKitException {
  const LiveActivityException(super.message, {super.widgetId, super.cause});
}
