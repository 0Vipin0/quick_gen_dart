class JsonExpressionHelpers {
  static String _checkVariableNameEmpty(
      {required String variableName, required String notEmptyValue}) {
    return variableName == "" ? "" : notEmptyValue;
  }

  static String _checkVariableNameAndTypeEmpty({
    required String variableName,
    required String variableType,
    required String notEmptyValue,
  }) {
    return variableName == "" || variableType == "" ? "" : notEmptyValue;
  }

  static String getColonSeparatedVariableWithTypeCasting({
    required String variableName,
    required String variableType,
  }) {
    return _checkVariableNameAndTypeEmpty(
      variableName: variableName,
      variableType: variableType,
      notEmptyValue:
          "\t\t$variableName: json['$variableName'] as $variableType,\n",
    );
  }

  static String getColonSeparatedDateTimeVariable({
    required String variableName,
  }) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue:
          "\t\t$variableName: DateTime.tryParse(json['$variableName']),\n",
    );
  }
}
