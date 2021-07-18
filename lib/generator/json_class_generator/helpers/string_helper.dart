class StringHelpers {
  static String capitalize(Match m) =>
      "${m[0]?.substring(0, 1).toUpperCase() ?? ""}${m[0]?.substring(1) ?? ""}";

  static String camelCase(String text) {
    String skip(String s) => "";
    return text.splitMapJoin(RegExp("r[a-zA-Z0-9]+"),
        onMatch: capitalize, onNonMatch: skip);
  }

  static String camelCaseFirstLower(String text) {
    final camelCaseText = camelCase(text);
    final firstChar = camelCaseText.substring(0, 1).toLowerCase();
    final rest = camelCaseText.substring(1);
    return '$firstChar$rest';
  }
}
