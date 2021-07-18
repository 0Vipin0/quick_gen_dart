import 'package:flutter_test/flutter_test.dart';
import 'package:quick_gen_dart/generator/json_class_generator/json_class_generator.dart';
import 'package:quick_gen_dart/generator/json_class_generator/nodes/json_list_node.dart';
import 'package:quick_gen_dart/generator/json_class_generator/nodes/json_node.dart';
import 'package:quick_gen_dart/generator/json_class_generator/nodes/json_object_node.dart';

void main() {
  group("Simple Json Class Generator", () {
    const String className = "Temp";
    const String rawJson = '''
{
  "age": "2021-07-15 11:11:58.324",
  "id": "0001",
  "totalUsers": 55,
  "isAdult": true,
  "totalAmount": 100.55,
  "activeUsers": 15,
  "categories": [
    "Pop",
    "Heavy Metal",
    "Power Bass"
  ]
}''';
    final JsonClassGenerator jsonClassGenerator = JsonClassGenerator(
      rawJson: rawJson,
      className: className,
    );
    decodeJsonTest(jsonClassGenerator);

    createJsonNodesTest(jsonClassGenerator);

    generateFromJsonMethod(jsonClassGenerator);
  });
}

void generateFromJsonMethod(JsonClassGenerator jsonClassGenerator) {
  return test("Generate fromJson Method", () {
    const String expectedFromJson = '''
factory Temp.fromJson(Map<String, dynamic> json) => Temp(
\t\tage: DateTime.tryParse(json['age']),
\t\tid: json['id'] as String,
\t\ttotalUsers: json['totalUsers'] as int,
\t\tisAdult: json['isAdult'] as bool,
\t\ttotalAmount: json['totalAmount'] as double,
\t\tactiveUsers: json['activeUsers'] as int,
\t\tcategories: List<String>.from(json['categories'].map((x) => x)),
\t);''';
    final String generatedFromJson = jsonClassGenerator.getFromJson();
    expect(generatedFromJson, expectedFromJson);
  });
}

void createJsonNodesTest(JsonClassGenerator jsonClassGenerator) {
  return test("Create Json Nodes", () {
    final List<dynamic> expectedJsonNodes = [
      JsonNode(
        variableName: "age",
        variableType: "DateTime",
        isPrimitive: false,
      ),
      JsonNode(
        variableName: "id",
        variableType: "String",
        isPrimitive: true,
      ),
      JsonNode(
        variableName: "totalUsers",
        variableType: "int",
        isPrimitive: true,
      ),
      JsonNode(
        variableName: "isAdult",
        variableType: "bool",
        isPrimitive: true,
      ),
      JsonNode(
        variableName: "totalAmount",
        variableType: "double",
        isPrimitive: true,
      ),
      JsonNode(
        variableName: "activeUsers",
        variableType: "int",
        isPrimitive: true,
      ),
      JsonListNode(
        variableName: "categories",
        listType: ListDataType.String,
        isAmbiguous: false,
      ),
    ];
    final JsonObjectNode expectedObjectNode = JsonObjectNode(
      className: jsonClassGenerator.className,
      nodes: expectedJsonNodes,
    );
    final Map<dynamic, dynamic> decodedJson =
        jsonClassGenerator.decodeRawJson();
    final JsonObjectNode generatedObjectNode =
        jsonClassGenerator.createJsonObjectNode(decodedJson);
    expect(generatedObjectNode.toString(), expectedObjectNode.toString());
  });
}

void decodeJsonTest(JsonClassGenerator jsonClassGenerator) {
  return test("Decode Json", () {
    final Map<String, dynamic> expectedDecodedJson = {
      "age": "2021-07-15 11:11:58.324",
      "id": "0001",
      "totalUsers": 55,
      "isAdult": true,
      "totalAmount": 100.55,
      "activeUsers": 15,
      "categories": ["Pop", "Heavy Metal", "Power Bass"],
    };
    final Map<dynamic, dynamic> decodedJson =
        jsonClassGenerator.decodeRawJson();
    expect(decodedJson, expectedDecodedJson);
  });
}
