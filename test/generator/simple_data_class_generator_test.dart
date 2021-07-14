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

    toStringTests(className, inputs);

    equalityTests(className, inputs);

    hashCodeTests(className, inputs);

    defaultConstructorTests(className, inputs);

    optionalConstructorTests(className, inputs);

    requiredOptionalConstructorTests(className, inputs);

    fromMapTests(className, inputs);

    toMapTests(className, inputs);

    copyWithTests(className, inputs);
  });
}

void fromMapTests(String className, List<Map<String, String>> inputs) {
  group("fromMap Tests", () {
    test("Empty fromMap Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedFromMap = '''
factory Temp.fromMap(Map<String, dynamic> map) => Temp();''';
      final String generatedFromMap = dataClassGenerator.getFromMap();
      expect(generatedFromMap, expectedFromMap);
    });

    test("fromMap Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedFromMap = '''
factory Temp.fromMap(Map<String, dynamic> map) => Temp(
\t\tage: map['age'] as DateTime,
\t\tid: map['id'] as String,
\t\ttotalUsers: map['totalUsers'] as int,
\t\tisAdult: map['isAdult'] as bool,
\t\ttotalAmount: map['totalAmount'] as double,
\t\tactiveUsers: map['activeUsers'] as num,
\t);''';
      final String generatedFromMap = dataClassGenerator.getFromMap();
      expect(generatedFromMap, expectedFromMap);
    });
  });
}

void toMapTests(String className, List<Map<String, String>> inputs) {
  group("toMap Tests", () {
    test("Empty toMap Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedToMap = '''
Map<String, dynamic> toMap() => <String, dynamic>{};''';
      final String generatedToMap = dataClassGenerator.getToMap();
      expect(generatedToMap, expectedToMap);
    });

    test("toMap Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedToMap = '''
Map<String, dynamic> toMap() => <String, dynamic>{
\t\t'age': age,
\t\t'id': id,
\t\t'totalUsers': totalUsers,
\t\t'isAdult': isAdult,
\t\t'totalAmount': totalAmount,
\t\t'activeUsers': activeUsers,
\t};''';
      final String generatedToMap = dataClassGenerator.getToMap();
      expect(generatedToMap, expectedToMap);
    });
  });
}

void copyWithTests(String className, List<Map<String, String>> inputs) {
  group("copyWith Tests", () {
    test("Empty copyWith Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedCopyWith = '''
Temp copyWith() => Temp();''';
      final String generatedCopyWith = dataClassGenerator.getCopyWith();
      expect(generatedCopyWith, expectedCopyWith);
    });

    test("copyWith Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedCopyWith = '''
Temp copyWith({
\tDateTime age,
\tString id,
\tint totalUsers,
\tbool isAdult,
\tdouble totalAmount,
\tnum activeUsers,
}) => Temp(
\t\tage: age ?? this.age,
\t\tid: id ?? this.id,
\t\ttotalUsers: totalUsers ?? this.totalUsers,
\t\tisAdult: isAdult ?? this.isAdult,
\t\ttotalAmount: totalAmount ?? this.totalAmount,
\t\tactiveUsers: activeUsers ?? this.activeUsers,
\t);''';
      final String generatedCopyWith = dataClassGenerator.getCopyWith();
      expect(generatedCopyWith, expectedCopyWith);
    });
  });
}

void requiredOptionalConstructorTests(
    String className, List<Map<String, String>> inputs) {
  group("Required Optional Constructor Tests", () {
    test("Empty Required Optional Constructor Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedRequiredOptionalConstructor = '''
const Temp();''';

      final String generatedRequiredOptionalConstructor =
          dataClassGenerator.getRequiredOptionalConstructor();
      expect(generatedRequiredOptionalConstructor,
          expectedRequiredOptionalConstructor);
    });

    test("Required Optional Constructor Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedRequiredOptionalConstructor = '''
Temp({
\t@required this.age,
\t@required this.id,
\t@required this.totalUsers,
\t@required this.isAdult,
\t@required this.totalAmount,
\t@required this.activeUsers,
});''';

      final String generatedRequiredOptionalConstructor =
          dataClassGenerator.getRequiredOptionalConstructor();
      expect(generatedRequiredOptionalConstructor,
          expectedRequiredOptionalConstructor);
    });
  });
}

void optionalConstructorTests(
    String className, List<Map<String, String>> inputs) {
  group("Optional Constructor Tests", () {
    test("Empty Optional Constructor Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedOptionalConstructor = '''
const Temp();''';

      final String generatedOptionalConstructor =
          dataClassGenerator.getOptionalConstructor();
      expect(generatedOptionalConstructor, expectedOptionalConstructor);
    });

    test("Optional Constructor Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedOptionalConstructor = '''
Temp({
\tthis.age,
\tthis.id,
\tthis.totalUsers,
\tthis.isAdult,
\tthis.totalAmount,
\tthis.activeUsers,
});''';

      final String generatedOptionalConstructor =
          dataClassGenerator.getOptionalConstructor();
      expect(generatedOptionalConstructor, expectedOptionalConstructor);
    });
  });
}

void defaultConstructorTests(
    String className, List<Map<String, String>> inputs) {
  group("Default Constructor Tests", () {
    test("Empty Constructor Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedDefaultConstructor = '''
const Temp();''';

      final String generatedDefaultConstructor =
          dataClassGenerator.getDefaultConstructor();
      expect(generatedDefaultConstructor, expectedDefaultConstructor);
    });

    test("Default Constructor Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedDefaultConstructor = '''
Temp(
\tthis.age,
\tthis.id,
\tthis.totalUsers,
\tthis.isAdult,
\tthis.totalAmount,
\tthis.activeUsers,
);''';
      final String generatedDefaultConstructor =
          dataClassGenerator.getDefaultConstructor();
      expect(generatedDefaultConstructor, expectedDefaultConstructor);
    });
  });
}

void hashCodeTests(String className, List<Map<String, String>> inputs) {
  return group("hash code Tests", () {
    test("Empty hash code Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedHashCode = '''
@override
int get hashCode => 0;''';

      final String generatedHashCode = dataClassGenerator.getHashCode();

      expect(generatedHashCode, expectedHashCode);
    });

    test("hash code Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedHashCode = '''
@override
int get hashCode =>
\tage.hashCode ^
\tid.hashCode ^
\ttotalUsers.hashCode ^
\tisAdult.hashCode ^
\ttotalAmount.hashCode ^
\tactiveUsers.hashCode;''';

      final String generatedHashCode = dataClassGenerator.getHashCode();

      expect(generatedHashCode, expectedHashCode);
    });
  });
}

void equalityTests(String className, List<Map<String, String>> inputs) {
  return group("Equality Tests", () {
    test("Empty equality Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedEquality = '''
@override
bool operator == (Object other) =>
\tidentical(this, other) ||
\t(other is Temp &&
\truntimeType == other.runtimeType);''';
      final generatedEquality = dataClassGenerator.getEquality();
      expect(generatedEquality, expectedEquality);
    });

    test("equality Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedEquality = '''
@override
bool operator == (Object other) =>
\tidentical(this, other) ||
\t(other is Temp &&
\truntimeType == other.runtimeType &&
\tage == other.age &&
\tid == other.id &&
\ttotalUsers == other.totalUsers &&
\tisAdult == other.isAdult &&
\ttotalAmount == other.totalAmount &&
\tactiveUsers == other.activeUsers);''';
      final generatedEquality = dataClassGenerator.getEquality();
      expect(generatedEquality, expectedEquality);
    });
  });
}

void toStringTests(String className, List<Map<String, String>> inputs) {
  return group("toString Tests", () {
    test("Empty toString Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedToString = '''
@override
String toString() {
\treturn 'Temp{}';
}''';
      final String generatedToString = dataClassGenerator.getToString();

      expect(generatedToString, expectedToString);
    });

    test("Simple toString Test", () {
      final DataClassGenerator dataClassGenerator = DataClassGenerator(
        className: className,
        inputs: inputs,
      );
      const String expectedToString = '''
@override
String toString() {
\treturn 'Temp{age: \$age, id: \$id, totalUsers: \$totalUsers, isAdult: \$isAdult, totalAmount: \$totalAmount, activeUsers: \$activeUsers}';
}''';
      final String generatedToString = dataClassGenerator.getToString();

      expect(generatedToString, expectedToString);
    });
  });
}
