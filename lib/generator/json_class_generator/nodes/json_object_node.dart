class JsonObjectNode {
  String className;
  List<dynamic> nodes;

  JsonObjectNode({
    required this.className,
    required this.nodes,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonObjectNode &&
          runtimeType == other.runtimeType &&
          className == other.className &&
          nodes == other.nodes;

  @override
  int get hashCode => className.hashCode ^ nodes.hashCode;

  @override
  String toString() {
    return 'JsonObjectNode{className: $className, nodes: $nodes}';
  }
}
