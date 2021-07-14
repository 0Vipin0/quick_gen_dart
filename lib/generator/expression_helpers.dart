class ExpressionHelpers {
  static String getColonSeparatedVariable({required String variableName}) {
    return "$variableName: \$$variableName";
  }

  static String getColonSeparatedVariableEndingWithComma(
      {required String variableName}) {
    return "$variableName: \$$variableName, ";
  }
}
