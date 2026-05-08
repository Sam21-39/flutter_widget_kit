import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

class TypeMapper {
  final DartType type;
  final String fieldName;
  final String className;

  TypeMapper(this.type, {required this.fieldName, required this.className});

  String toSwiftType() {
    final baseType = _mapBaseType(platform: 'swift');
    return type.nullabilitySuffix == NullabilitySuffix.question ? "$baseType?" : baseType;
  }

  String toKotlinType() {
    final baseType = _mapBaseType(platform: 'kotlin');
    return type.isNullable ? "$baseType?" : baseType;
  }

  String _mapBaseType({required String platform}) {
    if (type.isDartCoreString) return "String";
    if (type.isDartCoreInt) return platform == 'swift' ? 'Int' : 'Int';
    if (type.isDartCoreDouble) return platform == 'swift' ? 'Double' : 'Double';
    if (type.isDartCoreBool) return platform == 'swift' ? 'Bool' : 'Boolean';

    final typeName = type.getDisplayString(withNullability: false);

    if (typeName == 'DateTime') {
      return platform == 'swift' ? 'Date' : 'Instant';
    }

    if (type.isDartCoreList) {
      final inner = (type as ParameterizedType).typeArguments.first;
      final innerMapped =
          TypeMapper(inner, fieldName: fieldName, className: className);
      return platform == 'swift'
          ? "[${innerMapped.toSwiftType()}]"
          : "List<${innerMapped.toKotlinType()}>";
    }

    if (type.isDartCoreMap) {
      final key = (type as ParameterizedType).typeArguments.first;
      final value = (type as ParameterizedType).typeArguments.last;
      if (!key.isDartCoreString) {
        throw UnsupportedTypeError(
          'Map keys must be String. Found ${key.getDisplayString(withNullability: true)}',
          fieldName: fieldName,
          className: className,
        );
      }
      final valueMapped =
          TypeMapper(value, fieldName: fieldName, className: className);
      return platform == 'swift'
          ? "[String: ${valueMapped.toSwiftType()}]"
          : "Map<String, ${valueMapped.toKotlinType()}>";
    }

    // Default to type name for custom classes/enums
    return typeName;
  }
}

class UnsupportedTypeError extends Error {
  final String message;
  final String fieldName;
  final String className;

  UnsupportedTypeError(this.message,
      {required this.fieldName, required this.className});

  @override
  String toString() =>
      "UnsupportedTypeError: $message in $className.$fieldName";
}
