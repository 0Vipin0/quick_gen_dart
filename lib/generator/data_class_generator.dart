import 'package:quick_gen_dart/generator/constants.dart';
import 'package:quick_gen_dart/generator/expression_helpers.dart';
import 'package:quick_gen_dart/generator/templates.dart';

class DataClassGenerator {
  String className;
  List<Map<String, String>> inputs;

  DataClassGenerator({
    required this.className,
    required this.inputs,
  });

  String getToString() {
    if (inputs.isNotEmpty) {
      return _getGeneratedToString();
    }
    return Templates.toStringTemplate(className: className, content: '');
  }

  String _getGeneratedToString() {
    final StringBuffer sb = StringBuffer();

    for (int i = 0; i < inputs.length - 1; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      sb.write(ExpressionHelpers.getColonSeparatedVariableEndingWithComma(
          variableName: variableName ?? ""));
    }

    final String? lastVariableName = inputs[inputs.length - 1][VARIABLE_NAME];
    sb.write(ExpressionHelpers.getColonSeparatedVariable(
        variableName: lastVariableName ?? ""));

    return Templates.toStringTemplate(
        className: className, content: sb.toString());
  }

  String getEquality() {
    if (inputs.isNotEmpty) {
      return _getGeneratesEquality();
    }
    return Templates.toEqualityTemplate(className: className, content: '');
  }

  String _getGeneratesEquality() {
    final StringBuffer sb = StringBuffer();
    sb.write(" &&\n");

    for (int i = 0; i < inputs.length - 1; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      sb.write(ExpressionHelpers.getEqualitySeparatedVariableWithAnd(
          variableName: variableName ?? ""));
    }

    final String? lastVariableName = inputs[inputs.length - 1][VARIABLE_NAME];
    sb.write(ExpressionHelpers.getEqualitySeparatedVariable(
        variableName: lastVariableName ?? ""));
    return Templates.toEqualityTemplate(
        className: className, content: sb.toString());
  }
}
