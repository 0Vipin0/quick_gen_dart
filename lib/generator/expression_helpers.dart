class ExpressionHelpers {
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

  static String getColonSeparatedVariable({required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "$variableName: \$$variableName",
    );
  }

  static String getColonSeparatedVariableEndingWithComma(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "$variableName: \$$variableName, ",
    );
  }

  static String getEqualitySeparatedVariable({required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName == other.$variableName",
    );
  }

  static String getEqualitySeparatedVariableWithAnd(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName == other.$variableName &&\n",
    );
  }

  static String getHashCodeSeparatedVariableWithAnd(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName.hashCode ^\n",
    );
  }

  static String getHashCodeSeparatedVariable({required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName.hashCode",
    );
  }

  static String getDefaultConstructorWithComma({required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\tthis.$variableName,\n",
    );
  }

  static String getRequiredConstructorWithComma(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t@required this.$variableName,\n",
    );
  }

  static String getTypeSeparatedVariableWithComma(
      {required String variableName, required String variableType}) {
    return _checkVariableNameAndTypeEmpty(
      variableName: variableName,
      variableType: variableType,
      notEmptyValue: "\t$variableType $variableName,\n",
    );
  }

  static String getColonSeparatedVariableWithCommaAndNull(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue:
          "\t\t$variableName: $variableName ?? this.$variableName,\n",
    );
  }
}
