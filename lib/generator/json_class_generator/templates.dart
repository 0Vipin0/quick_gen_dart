class JsonClassTemplates {
  static String toFromJsonTemplate({
    required String className,
    required String content,
    required bool shouldAddConst,
  }) {
    return '''
factory $className.fromJson(${!shouldAddConst ? "Map<String, dynamic> json" : ""}) => ${shouldAddConst ? "const " : ""}$className($content);''';
  }
}
