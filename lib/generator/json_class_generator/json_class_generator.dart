import 'dart:convert';

import 'package:quick_gen_dart/generator/constants.dart';
import 'package:quick_gen_dart/generator/json_class_generator/data_type_helpers.dart';
import 'package:quick_gen_dart/generator/json_class_generator/json_expression_helpers.dart';
import 'package:quick_gen_dart/generator/json_class_generator/json_list.dart';
import 'package:quick_gen_dart/generator/json_class_generator/json_node.dart';
import 'package:quick_gen_dart/generator/json_class_generator/templates.dart';

class JsonClassGenerator {
  String className;
  String rawJson;

  JsonClassGenerator({required this.className, required this.rawJson});

  JsonDecoder decoder = const JsonDecoder();
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  String prettyPrintJson() {
    final StringBuffer prettyJsonBuffer = StringBuffer();
    final object = decoder.convert(rawJson);
    final prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((element) {
      prettyJsonBuffer.writeln(element);
    });
    return prettyJsonBuffer.toString();
  }

  Map<dynamic, dynamic> decodeRawJson() {
    return json.decode(rawJson) as Map<dynamic, dynamic>;
  }

  List<dynamic> createListJsonNode() {
    final Map<dynamic, dynamic> decodedJson = decodeRawJson();
    final List<dynamic> keysList = decodedJson.keys.toList();
    final List<dynamic> valuesList = decodedJson.values.toList();
    final List<dynamic> nodes = [];
    for (int i = 0; i < keysList.length; i++) {
      if (valuesList[i].runtimeType.toString() == LIST_DYNAMIC) {
        final JsonList jsonList = isListMergeAble(
          valuesList[i] as List<dynamic>,
          keysList[i] as String,
        );
        nodes.add(jsonList);
      } else {
        final bool isDateTime =
            DateTime.tryParse(valuesList[i].toString()) != null;
        final JsonNode jsonNode = JsonNode(
          variableName: keysList[i] as String,
          variableType:
              isDateTime ? "DateTime" : valuesList[i].runtimeType.toString(),
          isPrimitive: isPrimitiveType(
            isDateTime ? "DateTime" : valuesList[i].runtimeType.toString(),
          ),
        );
        nodes.add(jsonNode);
      }
    }
    return nodes;
  }

  String getFromJson() {
    final List<dynamic> nodes = createListJsonNode();
    if (nodes.isNotEmpty) {
      final StringBuffer contentBuffer = StringBuffer();
      contentBuffer.write("\n");
      for (int i = 0; i < nodes.length; i++) {
        if (nodes[i] is JsonList) {
          final String? variableName = nodes[i].variableName as String?;
          final ListDataType listType = nodes[i].listType as ListDataType;
          final bool isListAmbiguous = nodes[i].isAmbiguous as bool;
          if (!isListAmbiguous) {
            contentBuffer.write(
                JsonExpressionHelpers.getColonSeparatedDynamicListVariable(
              listType: listType,
              variableName: variableName ?? "",
            ));
          } else {
            // TODO: Handle Warning here
          }
        } else {
          final String? variableName = nodes[i].variableName as String?;
          final String? variableType = nodes[i].variableType as String?;
          if (variableType == "DateTime") {
            contentBuffer
                .write(JsonExpressionHelpers.getColonSeparatedDateTimeVariable(
              variableName: variableName ?? "",
            ));
          } else {
            contentBuffer.write(
                JsonExpressionHelpers.getColonSeparatedVariableWithTypeCasting(
              variableName: variableName ?? "",
              variableType: variableType ?? "",
            ));
          }
        }
      }
      contentBuffer.write("\t");
      return JsonClassTemplates.toFromJsonTemplate(
        className: className,
        content: contentBuffer.toString(),
        shouldAddConst: false,
      );
    }

    return JsonClassTemplates.toFromJsonTemplate(
      className: className,
      content: "",
      shouldAddConst: true,
    );
  }
}
