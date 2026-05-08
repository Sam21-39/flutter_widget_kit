import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import '../models/widget_metadata.dart';

class AnnotationParser {
  final ConstantReader annotation;
  final ClassElement element;

  AnnotationParser(this.element, this.annotation);

  WidgetMetadata parse() {
    _validateFreezed();

    final widgetId = annotation.read('widgetId').stringValue;
    _validateWidgetId(widgetId);

    final appGroupId = annotation.read('appGroupId').stringValue;
    _validateAppGroupId(appGroupId);

    return WidgetMetadata(
      className: element.name,
      widgetId: widgetId,
      appGroupId: appGroupId,
      androidNamespace: annotation.read('androidNamespace').stringValue,
      displayName: annotation.read('displayName').stringValue,
      description: annotation.read('description').stringValue,
      supportedFamilies: _parseFamilies(),
      placeholderStrategy:
          annotation.read('placeholderStrategy').objectValue.toString(),
      previewable: annotation.read('previewable').boolValue,
      updateStrategy: _parseUpdateStrategy(),
      fields: _parseFields(),
    );
  }

  void _validateFreezed() {
    final hasFreezed = element.metadata.any((m) =>
        m
                .computeConstantValue()
                ?.type
                ?.getDisplayString(withNullability: false) ==
            'Freezed' ||
        m.element?.displayName == 'freezed');
    if (!hasFreezed) {
      throw InvalidGenerationSourceError(
        'Classes annotated with @WidgetDefinition must also be annotated with @freezed.',
        element: element,
      );
    }
  }

  void _validateWidgetId(String id) {
    final regex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!regex.hasMatch(id)) {
      throw InvalidGenerationSourceError(
        'widgetId "$id" contains invalid characters. Use only alphanumeric and underscores.',
        element: element,
      );
    }
  }

  void _validateAppGroupId(String id) {
    if (!id.startsWith('group.')) {
      throw InvalidGenerationSourceError(
        'appGroupId "$id" is invalid. It must start with "group." (e.g., group.com.example.app).',
        element: element,
      );
    }
  }

  List<String> _parseFamilies() {
    // Implementation for family extraction
    return [];
  }

  UpdateMetadata _parseUpdateStrategy() {
    // Implementation for update strategy extraction
    return ManualUpdateMetadata();
  }

  List<FieldMetadata> _parseFields() {
    return element.unnamedConstructor?.parameters.map((p) {
          return FieldMetadata(
            name: p.name,
            type: p.type,
            isNullable: p.type.nullabilitySuffix == NullabilitySuffix.question,
          );
        }).toList() ??
        [];
  }
}
