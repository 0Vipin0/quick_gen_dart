import 'package:quick_gen_dart/generator/json_class_generator/json_list.dart';

class JsonExpressionHelpers {
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

  static String getColonSeparatedVariableWithTypeCasting({
    required String variableName,
    required String variableType,
  }) {
    return _checkVariableNameAndTypeEmpty(
      variableName: variableName,
      variableType: variableType,
      notEmptyValue:
          "\t\t$variableName: json['$variableName'] as $variableType,\n",
    );
  }

  static String getColonSeparatedDateTimeVariable({
    required String variableName,
  }) {
    return _checkVariableNameEmpty(
      variableName: variableName,
      notEmptyValue:
          "\t\t$variableName: DateTime.tryParse(json['$variableName']),\n",
    );
  }

  static String getColonSeparatedDynamicListVariable(
      {required String variableName, required ListDataType listType}) {
    return '''\t\t$variableName: List<${getListDataTypeString(listType)}>.from(json['$variableName'].map((x) => x)),\n''';
  }
}
