import 'package:quick_gen_dart/json_ast/json_ast.dart';

class JsonNode {
  String variableName;
  bool isPrimitive;
  bool? isAmbiguous;
  dynamic variableType;
  dynamic variableSubType;

  JsonNode({
    required this.variableName,
    required this.variableType,
    required this.isPrimitive,
    this.isAmbiguous,
    this.variableSubType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonNode &&
          runtimeType == other.runtimeType &&
          variableName == other.variableName &&
          isPrimitive == other.isPrimitive &&
          isAmbiguous == other.isAmbiguous &&
          variableType == other.variableType &&
          variableSubType == other.variableSubType;

  @override
  int get hashCode =>
      variableName.hashCode ^
      isPrimitive.hashCode ^
      isAmbiguous.hashCode ^
      variableType.hashCode ^
      variableSubType.hashCode;

  @override
  String toString() {
    return 'JsonNode{variableName: $variableName, isPrimitive: $isPrimitive, isAmbiguous: $isAmbiguous, variableType: $variableType, variableSubType: $variableSubType}';
  }
}

Node? navigateNode(Node currentNode, String path) {
  Node? node;
  if (currentNode is ObjectNode) {
    final ObjectNode objectNode = currentNode;
    final PropertyNode propertyNode =
        objectNode.children.firstWhere((final prop) => prop.key?.value == path);
    node = propertyNode.value;
  }
  if (currentNode is ArrayNode) {
    final ArrayNode arrayNode = currentNode;
    final index = int.tryParse(path);
    if (index != null && arrayNode.children.length > index) {
      node = arrayNode.children[index];
    }
  }
  return node;
}
