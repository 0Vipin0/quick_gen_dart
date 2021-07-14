class ExpressionHelpers {
  static String getColonSeparatedVariable({required String variableName}) {
    return "$variableName: \$$variableName";
  }

  static String getColonSeparatedVariableEndingWithComma(
      {required String variableName}) {
    return "$variableName: \$$variableName, ";
  }

  static String getEqualitySeparatedVariable({required String variableName}) {
    return "  $variableName == other.$variableName";
  }

  static String getEqualitySeparatedVariableWithAnd(
      {required String variableName}) {
    return "  $variableName == other.$variableName &&\n";
  }
}
