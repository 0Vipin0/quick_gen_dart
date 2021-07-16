class JsonList {
  ListDataType listType;
  bool isAmbiguous;

  JsonList({
    required this.listType,
    required this.isAmbiguous,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonList &&
          runtimeType == other.runtimeType &&
          listType == other.listType &&
          isAmbiguous == other.isAmbiguous;

  @override
  int get hashCode => listType.hashCode ^ isAmbiguous.hashCode;
}

enum ListDataType {
  Object,
  String,
  Double,
  Int,
  Null,
}

JsonList isListMergeAble(List<dynamic> unsafeList) {
  ListDataType t = ListDataType.Null;
  bool isAmbiguous = false;
  unsafeList.forEach((e) {
    ListDataType? inferredType;
    if (e.runtimeType is int) {
      inferredType = ListDataType.Int;
    } else if (e.runtimeType is double) {
      inferredType = ListDataType.Double;
    } else if (e.runtimeType is String) {
      inferredType = ListDataType.String;
    } else if (e is Map) {
      inferredType = ListDataType.Object;
    } else {
      isAmbiguous = true;
    }
    t = inferredType ?? ListDataType.Null;
  });
  return JsonList(
    listType: t,
    isAmbiguous: isAmbiguous,
  );
}
