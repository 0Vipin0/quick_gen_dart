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

  static String getEqualitySeparatedVariableEndingWithAnd(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName == other.$variableName &&\n",
    );
  }

  static String getHashCodeSeparatedVariableEndingWithAnd(
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

  static String getDefaultConstructorEndingWithComma(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\tthis.$variableName,\n",
    );
  }

  static String getRequiredConstructorEndingWithComma(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t@required this.$variableName,\n",
    );
  }

  static String getTypeSeparatedVariableEndingWithComma(
      {required String variableName, required String variableType}) {
    return _checkVariableNameAndTypeEmpty(
      variableName: variableName,
      variableType: variableType,
      notEmptyValue: "\t$variableType $variableName,\n",
    );
  }

  static String getColonSeparatedVariableEndingWithCommaAndNull(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue:
          "\t\t$variableName: $variableName ?? this.$variableName,\n",
    );
  }

  static String getColonSeparatedVariableStartingWithTabEndingWithComma(
      {required String variableName}) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue: "\t\t'$variableName': $variableName,\n",
    );
  }

  static String getColonSeparatedVariableStartingWithTabEndingVariableType(
      {required String variableName, required String variableType}) {
    return _checkVariableNameAndTypeEmpty(
        variableName: variableName,
        variableType: variableType,
        notEmptyValue:
            "\t\t$variableName: map['$variableName'] as $variableType,\n");
  }

  static String getColonSeparatedVariableStartingWithTabEndingWithSemicolon(
      {required String variableName, required String variableType}) {
    return _checkVariableNameAndTypeEmpty(
      variableName: variableName,
      variableType: variableType,
      notEmptyValue: "\t$variableType $variableName;\n",
    );
  }
}
