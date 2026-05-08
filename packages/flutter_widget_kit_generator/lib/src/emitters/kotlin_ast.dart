abstract class KotlinElement {
  String toKotlinString();
}

class KotlinDataClass extends KotlinElement {
  final String name;
  final List<KotlinField> fields;
  final List<String> annotations;

  KotlinDataClass({
    required this.name,
    this.fields = const [],
    this.annotations = const [],
  });

  @override
  String toKotlinString() {
    final buffer = StringBuffer();
    for (final ann in annotations) {
      buffer.writeln("@$ann");
    }
    buffer.writeln("data class $name(");
    for (var i = 0; i < fields.length; i++) {
      final comma = i == fields.length - 1 ? "" : ",";
      buffer.writeln("  ${fields[i].toKotlinString()}$comma");
    }
    buffer.writeln(")");
    return buffer.toString();
  }
}

class KotlinField extends KotlinElement {
  final String name;
  final String type;
  final bool isMutable;
  final String? defaultValue;

  KotlinField({
    required this.name,
    required this.type,
    this.isMutable = false,
    this.defaultValue,
  });

  @override
  String toKotlinString() {
    final keyword = isMutable ? "var" : "val";
    final def = defaultValue != null ? " = $defaultValue" : "";
    return "$keyword $name: $type$def";
  }
}
