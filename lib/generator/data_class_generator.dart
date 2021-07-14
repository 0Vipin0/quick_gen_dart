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

  DataClassGenerator copyWith({
    String? className,
    List<Map<String, String>>? inputs,
  }) =>
      DataClassGenerator(
        className: className ?? this.className,
        inputs: inputs ?? this.inputs,
      );

  @override
  String toString() {
    return 'DataClassGenerator{className: $className, inputs: $inputs}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataClassGenerator &&
          runtimeType == other.runtimeType &&
          className == other.className &&
          inputs == other.inputs);

  @override
  int get hashCode => className.hashCode ^ inputs.hashCode;

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
}
