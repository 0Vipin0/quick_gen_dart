class JsonListNode {
  String variableName;
  ListDataType listType;
  bool isAmbiguous;

  JsonListNode({
    required this.variableName,
    required this.listType,
    required this.isAmbiguous,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonListNode &&
          runtimeType == other.runtimeType &&
          variableName == other.variableName &&
          listType == other.listType &&
          isAmbiguous == other.isAmbiguous;

  @override
  int get hashCode =>
      variableName.hashCode ^ listType.hashCode ^ isAmbiguous.hashCode;

  @override
  String toString() {
    return 'JsonList{variableName: $variableName, listType: $listType, isAmbiguous: $isAmbiguous}';
  }
}

enum ListDataType {
  Object,
  String,
  Double,
  Int,
  Null,
}

JsonListNode isListMergeAble(List<dynamic> unsafeList, String variableName) {
  ListDataType t = ListDataType.Null;
  bool isAmbiguous = false;
  unsafeList.forEach((e) {
    ListDataType? inferredType;
    if (e.runtimeType.toString() == "int") {
      inferredType = ListDataType.Int;
    } else if (e.runtimeType.toString() == "double") {
      inferredType = ListDataType.Double;
    } else if (e.runtimeType.toString() == "String") {
      inferredType = ListDataType.String;
    } else if (e is Map) {
      inferredType = ListDataType.Object;
    } else {
      isAmbiguous = true;
    }
    t = inferredType ?? ListDataType.Null;
  });
  return JsonListNode(
    listType: t,
    variableName: variableName,
    isAmbiguous: isAmbiguous,
  );
}

String getListDataTypeString(ListDataType listType) {
  if (listType == ListDataType.Double) {
    return "double";
  } else if (listType == ListDataType.String) {
    return "String";
  } else if (listType == ListDataType.Int) {
    return "int";
  } else if (listType == ListDataType.Null) {
    return "null";
  }
  return "";
}
