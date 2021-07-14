import 'package:quick_gen_dart/generator/constants.dart';
import 'package:quick_gen_dart/generator/expression_helpers.dart';
import 'package:quick_gen_dart/generator/templates.dart';

enum Constructor {
  DEFAULT,
  OPTIONAL,
  REQUIRED_OPTIONAL,
}

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

  String getHashCode() {
    if (inputs.isNotEmpty) {
      final StringBuffer sb = StringBuffer();
      sb.write("\n");
      for (int i = 0; i < inputs.length - 1; i++) {
        final String? variableName = inputs[i][VARIABLE_NAME];
        sb.write(ExpressionHelpers.getHashCodeSeparatedVariableWithAnd(
            variableName: variableName ?? ""));
      }
      final String? lastVariableName = inputs[inputs.length - 1][VARIABLE_NAME];
      sb.write(ExpressionHelpers.getHashCodeSeparatedVariable(
          variableName: lastVariableName ?? ""));
      return Templates.toHashCodeTemplate(
          className: className, content: sb.toString());
    }
    return Templates.toHashCodeTemplate(className: className, content: " 0");
  }

  String _getConstructor(Constructor constructor) {
    if (inputs.isNotEmpty) {
      return _getGeneratedConstructor(constructor);
    }
    return Templates.toConstructor(
      className: className,
      content: "",
      shouldAddConst: true,
    );
  }

  String _getGeneratedConstructor(Constructor constructor) {
    final StringBuffer sb = StringBuffer();
    if (constructor == Constructor.DEFAULT) {
      sb.write("\n");
    } else {
      sb.write("{\n");
    }
    for (int i = 0; i < inputs.length; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      if (constructor == Constructor.REQUIRED_OPTIONAL) {
        sb.write(ExpressionHelpers.getRequiredConstructorWithComma(
            variableName: variableName ?? ""));
      } else {
        sb.write(ExpressionHelpers.getDefaultConstructorWithComma(
            variableName: variableName ?? ""));
      }
    }
    if (constructor != Constructor.DEFAULT) {
      sb.write("}");
    }
    return Templates.toConstructor(
      className: className,
      content: sb.toString(),
      shouldAddConst: false,
    );
  }

  String getDefaultConstructor() {
    return _getConstructor(Constructor.DEFAULT);
  }

  String getOptionalConstructor() {
    return _getConstructor(Constructor.OPTIONAL);
  }

  String getRequiredOptionalConstructor() {
    return _getConstructor(Constructor.REQUIRED_OPTIONAL);
  }
}
