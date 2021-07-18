import 'dart:convert';

import 'package:quick_gen_dart/generator/constants.dart';
import 'package:quick_gen_dart/generator/json_class_generator/data_type_helpers.dart';
import 'package:quick_gen_dart/generator/json_class_generator/json_expression_helpers.dart';
import 'package:quick_gen_dart/generator/json_class_generator/nodes/json_list_node.dart';
import 'package:quick_gen_dart/generator/json_class_generator/nodes/json_node.dart';
import 'package:quick_gen_dart/generator/json_class_generator/nodes/json_object_node.dart';
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

  JsonObjectNode createListJsonNode(Map<dynamic, dynamic> decodedJson) {
    final List<dynamic> keysList = decodedJson.keys.toList();
    final List<dynamic> valuesList = decodedJson.values.toList();
    final List<dynamic> nodes = [];
    for (int i = 0; i < keysList.length; i++) {
      if (valuesList[i].runtimeType.toString() == LIST_DYNAMIC) {
        final JsonListNode jsonList = isListMergeAble(
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
    return JsonObjectNode(
      className: className,
      nodes: nodes,
    );
  }

  String getFromJson() {
    final Map<dynamic, dynamic> decodedJson = decodeRawJson();
    final JsonObjectNode objectNode = createListJsonNode(decodedJson);
    if (objectNode.nodes.isNotEmpty) {
      final StringBuffer contentBuffer = StringBuffer();
      contentBuffer.write("\n");
      for (int i = 0; i < objectNode.nodes.length; i++) {
        if (objectNode.nodes[i] is JsonListNode) {
          final String listNodeString =
              _handleJsonListNode(objectNode.nodes[i] as JsonListNode);
          contentBuffer.write(listNodeString);
        } else {
          final String jsonNodeString =
              _handleJsonNode(objectNode.nodes[i] as JsonNode);
          contentBuffer.write(jsonNodeString);
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

  String _handleJsonNode(JsonNode jsonNode) {
    final StringBuffer contentBuffer = StringBuffer();
    final String variableName = jsonNode.variableName;
    final String? variableType = jsonNode.variableType as String?;
    if (variableType == "DateTime") {
      contentBuffer
          .write(JsonExpressionHelpers.getColonSeparatedDateTimeVariable(
        variableName: variableName,
      ));
    } else {
      contentBuffer
          .write(JsonExpressionHelpers.getColonSeparatedVariableWithTypeCasting(
        variableName: variableName,
        variableType: variableType ?? "",
      ));
    }
    return contentBuffer.toString();
  }

  String _handleJsonListNode(JsonListNode jsonListNode) {
    final StringBuffer contentBuffer = StringBuffer();
    final String variableName = jsonListNode.variableName;
    final ListDataType listType = jsonListNode.listType;
    final bool isListAmbiguous = jsonListNode.isAmbiguous;
    if (!isListAmbiguous) {
      contentBuffer
          .write(JsonExpressionHelpers.getColonSeparatedDynamicListVariable(
        listType: listType,
        variableName: variableName,
      ));
      return contentBuffer.toString();
    } else {
      // TODO: Handle Warning here
      return "";
    }
  }
}
