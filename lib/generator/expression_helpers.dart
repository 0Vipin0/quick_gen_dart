class ExpressionHelpers {
  static String getColonSeparatedVariable({required String variableName}) {
    return "$variableName: \$$variableName";
  }

  static String getColonSeparatedVariableEndingWithComma(
      {required String variableName}) {
    return "$variableName: \$$variableName, ";
  }

  static String getEqualitySeparatedVariable({required String variableName}) {
    return "\t$variableName == other.$variableName";
  }

  static String getEqualitySeparatedVariableWithAnd(
      {required String variableName}) {
    return "\t$variableName == other.$variableName &&\n";
  }

  static String getHashCodeSeparatedVariableWithAnd(
      {required String variableName}) {
    return "\t$variableName.hashCode ^\n";
  }

  static String getHashCodeSeparatedVariable({required String variableName}) {
    return "\t$variableName.hashCode";
  }
}
