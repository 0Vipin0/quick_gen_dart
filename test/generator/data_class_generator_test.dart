import 'package:flutter_test/flutter_test.dart';
import 'package:quick_gen_dart/generator/constants.dart';
import 'package:quick_gen_dart/generator/data_class_generator.dart';

void main() {
  group("Simple Data Class Generator Tests", () {
    const String className = "Temp";
    final List<Map<String, String>> inputs = [
      {VARIABLE_NAME: "age", VARIABLE_TYPE: "DateTime"},
      {VARIABLE_NAME: "id", VARIABLE_TYPE: "String"},
      {VARIABLE_NAME: "totalUsers", VARIABLE_TYPE: "int"},
      {VARIABLE_NAME: "isAdult", VARIABLE_TYPE: "bool"},
      {VARIABLE_NAME: "totalAmount", VARIABLE_TYPE: "double"},
      {VARIABLE_NAME: "activeUsers", VARIABLE_TYPE: "num"},
    ];

    group("toString Tests", () {
      test("Empty toString Test", () {
        final DataClassGenerator dataClassGenerator =
            DataClassGenerator(className: className, inputs: []);
        const String expectedToString = '''
@override
String toString() {
  return 'Temp{}';
}
''';
        final String generatedToString = dataClassGenerator.getToString();

        expect(expectedToString, generatedToString);
      });

      test("Simple toString Test", () {
        final DataClassGenerator dataClassGenerator = DataClassGenerator(
          className: className,
          inputs: inputs,
        );
        const String expectedToString = '''
@override
String toString() {
  return 'Temp{age: \$age, id: \$id, totalUsers: \$totalUsers, isAdult: \$isAdult, totalAmount: \$totalAmount, activeUsers: \$activeUsers}';
}
''';
        final String generatedToString = dataClassGenerator.getToString();

        expect(expectedToString, generatedToString);
      });
    });

    test("equality Test", () {
      const String expectedEquality = '''
@override
bool operator ==(Object other) =>
  identical(this, other) ||
  (other is Temp &&
  runtimeType == other.runtimeType &&
  id == other.id &&
  age == other.age &&
  totalUsers == other.totalUsers &&
  isAdult == other.isAdult &&
  totalAmount == other.totalAmount &&
  activeUsers == other.activeUsers);      
''';
    });

    test("fromMap Test", () {
      const String expectedFromMap = '''
factory Temp.fromMap(Map<String, dynamic> map) {
  return Temp(
    id: map['id'] as String,
    age: map['age'] as DateTime,
    totalUsers: map['totalUsers'] as int,
    isAdult: map['isAdult'] as bool,
    totalAmount: map['totalAmount'] as double,
    activeUsers: map['activeUsers'] as num,
   );
 }
''';
    });

    test("toMap Test", () {
      const String expectedToMap = '''
Map<String, dynamic> toMap() {
  return <String, dynamic>{
    'id': this.id,
    'age': this.age,
    'totalUsers': this.totalUsers,
    'isAdult': this.isAdult,
    'totalAmount': this.totalAmount,
    'activeUsers': this.activeUsers,
  };
}
''';
    });

    test("copyWith Test", () {
      const String expectedCopyWith = '''
Temp copyWith({
  String id,
  DateTime age,
  int totalUsers,
  bool isAdult,
  double totalAmount,
  num activeUsers,
}) => Temp (
    id: id ?? this.id,
    age: age ?? this.age,
    totalUsers: totalUsers ?? this.totalUsers,
    isAdult: isAdult ?? this.isAdult,
    totalAmount: totalAmount ?? this.totalAmount,
    activeUsers: activeUsers ?? this.activeUsers,
  );
''';
    });
  });
}
