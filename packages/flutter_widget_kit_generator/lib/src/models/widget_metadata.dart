import 'package:analyzer/dart/element/type.dart';

/// Metadata extracted from @WidgetDefinition annotation.
class WidgetMetadata {
  final String className;
  final String widgetId;
  final String appGroupId;
  final String androidNamespace;
  final String displayName;
  final String description;
  final List<String> supportedFamilies;
  final String placeholderStrategy;
  final bool previewable;
  final UpdateMetadata updateStrategy;
  final List<FieldMetadata> fields;

  WidgetMetadata({
    required this.className,
    required this.widgetId,
    required this.appGroupId,
    required this.androidNamespace,
    required this.displayName,
    required this.description,
    required this.supportedFamilies,
    required this.placeholderStrategy,
    required this.previewable,
    required this.updateStrategy,
    required this.fields,
  });
}

/// Metadata for a field in the state class.
class FieldMetadata {
  final String name;
  final DartType type;
  final bool isNullable;
  final String? defaultValue;

  FieldMetadata({
    required this.name,
    required this.type,
    required this.isNullable,
    this.defaultValue,
  });
}

/// Metadata for update strategies.
abstract class UpdateMetadata {}

class ManualUpdateMetadata extends UpdateMetadata {}

class PeriodicUpdateMetadata extends UpdateMetadata {
  final Duration interval;
  final bool requiresNetwork;
  final bool requiresCharging;
  final bool requiresUnmeteredNetwork;

  PeriodicUpdateMetadata({
    required this.interval,
    required this.requiresNetwork,
    required this.requiresCharging,
    required this.requiresUnmeteredNetwork,
  });
}

class PushUpdateMetadata extends UpdateMetadata {
  final String? fcmTopic;
  final String? apnsTopic;

  PushUpdateMetadata({this.fcmTopic, this.apnsTopic});
}
