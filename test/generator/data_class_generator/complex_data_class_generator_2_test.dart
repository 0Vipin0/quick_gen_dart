import 'package:flutter_test/flutter_test.dart';
import 'package:quick_gen_dart/generator/constants.dart';
import 'package:quick_gen_dart/generator/data_class_generator/data_class_generator.dart';

void main() {
  const String className = "Temp";
  final List<Map<String, String>> inputs = [
    {
      VARIABLE_NAME: "categories",
      VARIABLE_TYPE: "List",
      VARIABLE_SUBTYPE: "DateTime"
    },
    {
      VARIABLE_NAME: "userChoices",
      VARIABLE_TYPE: "Map",
      VARIABLE_SUBTYPE_KEY: "String",
      VARIABLE_SUBTYPE_VALUE: "int",
    },
  ];
  final DataClassGenerator dataClassGenerator =
      DataClassGenerator(className: className, inputs: inputs);

  complexDataClassTests(dataClassGenerator);
}

void complexDataClassTests(DataClassGenerator dataClassGenerator) {
  group("Complex Data Class Generator", () {
    test("Complex fromMap Test", () {
      const String expectedFromMap = '''
factory Temp.fromMap(Map<String, dynamic> map) => Temp(
\t\tcategories: map['categories'] as List<DateTime>,
\t\tuserChoices: map['userChoices'] as Map<String, int>,
\t);''';
      final String generatedFromMap = dataClassGenerator.getFromMap();
      expect(generatedFromMap, expectedFromMap);
    });

    test("Complex toMap Test", () {
      const String expectedToMap = '''
Map<String, dynamic> toMap() => <String, dynamic>{
\t\t'categories': categories,
\t\t'userChoices': userChoices,
\t};''';
      final String generatedToMap = dataClassGenerator.getToMap();
      expect(generatedToMap, expectedToMap);
    });

    test("Complex toString Test", () {
      const String expectedToString = '''
@override
String toString() {
\treturn 'Temp{categories: \$categories, userChoices: \$userChoices}';
}''';
      final String generatedToString = dataClassGenerator.getToString();
      expect(generatedToString, expectedToString);
    });

    test("Complex HashCode Test", () {
      const String expectedHashCode = '''
@override
int get hashCode =>
\tcategories.hashCode ^
\tuserChoices.hashCode;''';
      final String generatedHashCode = dataClassGenerator.getHashCode();
      expect(generatedHashCode, expectedHashCode);
    });

    test("Complex Equality Test", () {
      const String expectedEquality = '''
@override
bool operator == (Object other) =>
\tidentical(this, other) ||
\t(other is Temp &&
\truntimeType == other.runtimeType &&
\tcategories == other.categories &&
\tuserChoices == other.userChoices);''';
      final String generatedEquality = dataClassGenerator.getEquality();
      expect(generatedEquality, expectedEquality);
    });

    test("Complex copyWith Test", () {
      const String expectedCopyWith = '''
Temp copyWith({
\tList<DateTime> categories,
\tMap<String, int> userChoices,
}) => Temp(
\t\tcategories: categories ?? this.categories,
\t\tuserChoices: userChoices ?? this.userChoices,
\t);''';

      final String generatedCopyWith = dataClassGenerator.getCopyWith();
      expect(generatedCopyWith, expectedCopyWith);
    });
  });
}
