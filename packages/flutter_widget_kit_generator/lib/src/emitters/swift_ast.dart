abstract class SwiftElement {
  String toSwiftString();
}

class SwiftStruct extends SwiftElement {
  final String name;
  final List<String> conformances;
  final List<SwiftField> fields;
  final List<SwiftElement> nested;

  SwiftStruct({
    required this.name,
    this.conformances = const [],
    this.fields = const [],
    this.nested = const [],
  });

  @override
  String toSwiftString() {
    final buffer = StringBuffer();
    final confStr = conformances.isEmpty ? "" : ": ${conformances.join(', ')}";
    buffer.writeln("struct $name$confStr {");
    for (final field in fields) {
      buffer.writeln("  ${field.toSwiftString()}");
    }
    for (final element in nested) {
      buffer.writeln(
          element.toSwiftString().split('\n').map((l) => "  $l").join('\n'));
    }
    buffer.writeln("}");
    return buffer.toString();
  }
}

class SwiftField extends SwiftElement {
  final String name;
  final String type;
  final bool isMutable;
  final String? initialValue;

  SwiftField({
    required this.name,
    required this.type,
    this.isMutable = false,
    this.initialValue,
  });

  @override
  String toSwiftString() {
    final keyword = isMutable ? "var" : "let";
    final init = initialValue != null ? " = $initialValue" : "";
    return "$keyword $name: $type$init";
  }
}

class SwiftEnum extends SwiftElement {
  final String name;
  final String? rawType;
  final List<String> cases;

  SwiftEnum({required this.name, this.rawType, this.cases = const []});

  @override
  String toSwiftString() {
    final buffer = StringBuffer();
    final rawStr = rawType != null ? ": $rawType" : "";
    buffer.writeln("enum $name$rawStr {");
    for (final c in cases) {
      buffer.writeln("  case $c");
    }
    buffer.writeln("}");
    return buffer.toString();
  }
}
