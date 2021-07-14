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
    final StringBuffer contentBuffer = StringBuffer();

    for (int i = 0; i < inputs.length - 1; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      contentBuffer.write(
          ExpressionHelpers.getColonSeparatedVariableEndingWithComma(
              variableName: variableName ?? ""));
    }

    final String? lastVariableName = inputs[inputs.length - 1][VARIABLE_NAME];
    contentBuffer.write(ExpressionHelpers.getColonSeparatedVariable(
        variableName: lastVariableName ?? ""));

    return Templates.toStringTemplate(
        className: className, content: contentBuffer.toString());
  }

  String getEquality() {
    if (inputs.isNotEmpty) {
      return _getGeneratesEquality();
    }
    return Templates.toEqualityTemplate(className: className, content: '');
  }

  String _getGeneratesEquality() {
    final StringBuffer contentBuffer = StringBuffer();
    contentBuffer.write(" &&\n");

    for (int i = 0; i < inputs.length - 1; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      contentBuffer.write(ExpressionHelpers.getEqualitySeparatedVariableWithAnd(
          variableName: variableName ?? ""));
    }

    final String? lastVariableName = inputs[inputs.length - 1][VARIABLE_NAME];
    contentBuffer.write(ExpressionHelpers.getEqualitySeparatedVariable(
        variableName: lastVariableName ?? ""));
    return Templates.toEqualityTemplate(
        className: className, content: contentBuffer.toString());
  }

  String getHashCode() {
    if (inputs.isNotEmpty) {
      return _getGeneratedHashCode();
    }
    return Templates.toHashCodeTemplate(className: className, content: " 0");
  }

  String _getGeneratedHashCode() {
    final StringBuffer contentBuffer = StringBuffer();
    contentBuffer.write("\n");
    for (int i = 0; i < inputs.length - 1; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      contentBuffer.write(ExpressionHelpers.getHashCodeSeparatedVariableWithAnd(
          variableName: variableName ?? ""));
    }
    final String? lastVariableName = inputs[inputs.length - 1][VARIABLE_NAME];
    contentBuffer.write(ExpressionHelpers.getHashCodeSeparatedVariable(
        variableName: lastVariableName ?? ""));
    return Templates.toHashCodeTemplate(
        className: className, content: contentBuffer.toString());
  }

  String _getConstructor(Constructor constructor) {
    if (inputs.isNotEmpty) {
      return _getGeneratedConstructor(constructor);
    }
    return Templates.toConstructorTemplate(
      className: className,
      content: "",
      shouldAddConst: true,
    );
  }

  String _getGeneratedConstructor(Constructor constructor) {
    final StringBuffer contentBuffer = StringBuffer();
    if (constructor == Constructor.DEFAULT) {
      contentBuffer.write("\n");
    } else {
      contentBuffer.write("{\n");
    }
    for (int i = 0; i < inputs.length; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      if (constructor == Constructor.REQUIRED_OPTIONAL) {
        contentBuffer.write(ExpressionHelpers.getRequiredConstructorWithComma(
            variableName: variableName ?? ""));
      } else {
        contentBuffer.write(ExpressionHelpers.getDefaultConstructorWithComma(
            variableName: variableName ?? ""));
      }
    }
    if (constructor != Constructor.DEFAULT) {
      contentBuffer.write("}");
    }
    return Templates.toConstructorTemplate(
      className: className,
      content: contentBuffer.toString(),
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

  String getCopyWith() {
    if (inputs.isNotEmpty) {
      final StringBuffer parameterBuffer = StringBuffer();
      final StringBuffer contentBuffer = StringBuffer();
      parameterBuffer.write("{\n");
      for (int i = 0; i < inputs.length; i++) {
        final String? variableName = inputs[i][VARIABLE_NAME];
        final String? variableType = inputs[i][VARIABLE_TYPE];
        parameterBuffer
            .write(ExpressionHelpers.getTypeSeparatedVariableWithComma(
          variableName: variableName ?? "",
          variableType: variableType ?? "",
        ));
      }
      parameterBuffer.write("}");
      contentBuffer.write("\n");
      for (int i = 0; i < inputs.length; i++) {
        final String? variableName = inputs[i][VARIABLE_NAME];
        contentBuffer
            .write(ExpressionHelpers.getColonSeparatedVariableWithCommaAndNull(
          variableName: variableName ?? "",
        ));
      }
      contentBuffer.write("\t");
      return Templates.toCopyWithTemplate(
        className: className,
        content: contentBuffer.toString(),
        parameters: parameterBuffer.toString(),
      );
    }
    return Templates.toCopyWithTemplate(
        className: className, content: "", parameters: "");
  }
}
