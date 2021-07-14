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
      contentBuffer.write(
          ExpressionHelpers.getEqualitySeparatedVariableEndingWithAnd(
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
      contentBuffer.write(
          ExpressionHelpers.getHashCodeSeparatedVariableEndingWithAnd(
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
        contentBuffer.write(
            ExpressionHelpers.getRequiredConstructorEndingWithComma(
                variableName: variableName ?? ""));
      } else {
        contentBuffer.write(
            ExpressionHelpers.getDefaultConstructorEndingWithComma(
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
      return Templates.toCopyWithTemplate(
        className: className,
        content: _generateCopyWithContent(),
        parameters: _generateCopyWithParameters(),
        shouldAddConst: false,
      );
    }
    return Templates.toCopyWithTemplate(
      className: className,
      content: "",
      parameters: "",
      shouldAddConst: true,
    );
  }

  String _generateCopyWithParameters() {
    final StringBuffer parameterBuffer = StringBuffer();
    parameterBuffer.write("{\n");
    for (int i = 0; i < inputs.length; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      final String? variableType = inputs[i][VARIABLE_TYPE];
      final String? variableSubType = inputs[i][VARIABLE_SUBTYPE];
      final String? variableSubTypeKey = inputs[i][VARIABLE_SUBTYPE_KEY];
      final String? variableSubTypeValue = inputs[i][VARIABLE_SUBTYPE_VALUE];
      if (variableSubType != null ||
          (variableSubTypeKey != null && variableSubTypeValue != null)) {
        if (variableType == LIST) {
          final String mergedVariableType = "$variableType<$variableSubType>";
          parameterBuffer
              .write(ExpressionHelpers.getTypeSeparatedVariableEndingWithComma(
            variableName: variableName ?? "",
            variableType: mergedVariableType,
          ));
        } else if (variableType == MAP) {
          final String mergedVariableType =
              "$variableType<$variableSubTypeKey, $variableSubTypeValue>";
          parameterBuffer
              .write(ExpressionHelpers.getTypeSeparatedVariableEndingWithComma(
            variableName: variableName ?? "",
            variableType: mergedVariableType,
          ));
        }
      } else {
        parameterBuffer
            .write(ExpressionHelpers.getTypeSeparatedVariableEndingWithComma(
          variableName: variableName ?? "",
          variableType: variableType ?? "",
        ));
      }
    }
    parameterBuffer.write("}");
    return parameterBuffer.toString();
  }

  String _generateCopyWithContent() {
    final StringBuffer contentBuffer = StringBuffer();
    contentBuffer.write("\n");
    for (int i = 0; i < inputs.length; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      contentBuffer.write(
          ExpressionHelpers.getColonSeparatedVariableEndingWithCommaAndNull(
        variableName: variableName ?? "",
      ));
    }
    contentBuffer.write("\t");
    return contentBuffer.toString();
  }

  String getToMap() {
    if (inputs.isNotEmpty) {
      final StringBuffer contentBuffer = StringBuffer();
      contentBuffer.write("\n");
      for (int i = 0; i < inputs.length; i++) {
        final String? variableName = inputs[i][VARIABLE_NAME];
        contentBuffer.write(ExpressionHelpers
            .getColonSeparatedVariableStartingWithTabEndingWithComma(
          variableName: variableName ?? "",
        ));
      }
      contentBuffer.write("\t");
      return Templates.toMapTemplate(
        content: contentBuffer.toString(),
      );
    }
    return Templates.toMapTemplate(content: "");
  }

  String getFromMap() {
    if (inputs.isNotEmpty) {
      final StringBuffer contentBuffer = StringBuffer();
      contentBuffer.write("\n");
      for (int i = 0; i < inputs.length; i++) {
        final String? variableName = inputs[i][VARIABLE_NAME];
        final String? variableType = inputs[i][VARIABLE_TYPE];
        final String? variableSubType = inputs[i][VARIABLE_SUBTYPE];
        final String? variableSubTypeKey = inputs[i][VARIABLE_SUBTYPE_KEY];
        final String? variableSubTypeValue = inputs[i][VARIABLE_SUBTYPE_VALUE];

        if (variableSubType != null ||
            (variableSubTypeKey != null && variableSubTypeValue != null)) {
          if (variableType == LIST) {
            final String mergedVariableType = "$variableType<$variableSubType>";
            contentBuffer.write(ExpressionHelpers
                .getColonSeparatedVariableStartingWithTabEndingVariableType(
              variableName: variableName ?? "",
              variableType: mergedVariableType,
            ));
          } else if (variableType == MAP) {
            final String mergedVariableType =
                "$variableType<$variableSubTypeKey, $variableSubTypeValue>";
            contentBuffer.write(ExpressionHelpers
                .getColonSeparatedVariableStartingWithTabEndingVariableType(
              variableName: variableName ?? "",
              variableType: mergedVariableType,
            ));
          }
        } else {
          contentBuffer.write(ExpressionHelpers
              .getColonSeparatedVariableStartingWithTabEndingVariableType(
            variableName: variableName ?? "",
            variableType: variableType ?? "",
          ));
        }
      }
      contentBuffer.write("\t");
      return Templates.toFromMapTemplate(
        className: className,
        content: contentBuffer.toString(),
        shouldAddConst: false,
      );
    }
    return Templates.toFromMapTemplate(
      className: className,
      content: "",
      shouldAddConst: true,
    );
  }

  String getVariables() {
    final StringBuffer contentBuffer = StringBuffer();
    for (int i = 0; i < inputs.length; i++) {
      final String? variableName = inputs[i][VARIABLE_NAME];
      final String? variableType = inputs[i][VARIABLE_TYPE];
      contentBuffer.write(ExpressionHelpers
          .getColonSeparatedVariableStartingWithTabEndingWithSemicolon(
        variableName: variableName ?? "",
        variableType: variableType ?? "",
      ));
    }
    return contentBuffer.toString();
  }

  String getDataClass(Constructor constructor) {
    final StringBuffer contentBuffer = StringBuffer();
    if (constructor == Constructor.REQUIRED_OPTIONAL && inputs.isNotEmpty) {
      contentBuffer.write("import 'package:flutter/foundation.dart';\n\n");
    }
    contentBuffer.write("class $className {\n");
    contentBuffer.write(getVariables());
    contentBuffer.write("\n");
    contentBuffer.write(_getConstructor(constructor));
    contentBuffer.write("\n\n");
    contentBuffer.write(getCopyWith());
    contentBuffer.write("\n\n");
    contentBuffer.write(getToString());
    contentBuffer.write("\n\n");
    contentBuffer.write(getEquality());
    contentBuffer.write("\n\n");
    contentBuffer.write(getHashCode());
    contentBuffer.write("\n\n");
    contentBuffer.write(getFromMap());
    contentBuffer.write("\n\n");
    contentBuffer.write(getToMap());
    contentBuffer.write("\n}");
    return contentBuffer.toString();
  }
}
