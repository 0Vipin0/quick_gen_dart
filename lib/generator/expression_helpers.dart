class ExpressionHelpers {
  static String _checkVariableEmpty(
      {required String variableName, required String notEmptyValue}) {
    return variableName == "" ? "" : notEmptyValue;
  }

  static String getColonSeparatedVariable({required String variableName}) {
    return _checkVariableEmpty(
      variableName: variableName,
      notEmptyValue: "$variableName: \$$variableName",
    );
  }

  static String getColonSeparatedVariableEndingWithComma(
      {required String variableName}) {
    return _checkVariableEmpty(
      variableName: variableName,
      notEmptyValue: "$variableName: \$$variableName, ",
    );
  }

  static String getEqualitySeparatedVariable({required String variableName}) {
    return _checkVariableEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName == other.$variableName",
    );
  }

  static String getEqualitySeparatedVariableWithAnd(
      {required String variableName}) {
    return _checkVariableEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName == other.$variableName &&\n",
    );
  }

  static String getHashCodeSeparatedVariableWithAnd(
      {required String variableName}) {
    return _checkVariableEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName.hashCode ^\n",
    );
  }

  static String getHashCodeSeparatedVariable({required String variableName}) {
    return _checkVariableEmpty(
      variableName: variableName,
      notEmptyValue: "\t$variableName.hashCode",
    );
  }

  static String getDefaultConstructorWithComma({required String variableName}) {
    return _checkVariableEmpty(
      variableName: variableName,
      notEmptyValue: "\tthis.$variableName,\n",
    );
  }
}
