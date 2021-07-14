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

//     test("fromMap Test", () {
//       const String expectedFromMap = '''
// factory Temp.fromMap(Map<String, dynamic> map) {
//   return Temp(
//     id: map['id'] as String,
//     age: map['age'] as DateTime,
//     totalUsers: map['totalUsers'] as int,
//     isAdult: map['isAdult'] as bool,
//     totalAmount: map['totalAmount'] as double,
//     activeUsers: map['activeUsers'] as num,
//    );
//  }
// ''';
//     });

    toMapTests(className, inputs);

    copyWithTests(className, inputs);
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
  \t\t'age': this.age,
  \t\t'id': this.id,
  \t\t'totalUsers': this.totalUsers,
  \t\t'isAdult': this.isAdult,
  \t\t'totalAmount': this.totalAmount,
  \t\t'activeUsers': this.activeUsers,
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

// class Temp {
//   DateTime age;
//   String id;
//   int totalUsers;
//   bool isAdult;
//   double totalAmount;
//   num activeUsers;
//
// //<editor-fold desc="Data Methods" defaultstate="collapsed">
//
//   Temp({
//     @required this.age,
//     @required this.id,
//     @required this.totalUsers,
//     @required this.isAdult,
//     @required this.totalAmount,
//     @required this.activeUsers,
//   });
//
//   Temp copyWith({
//     DateTime age,
//     String id,
//     int totalUsers,
//     bool isAdult,
//     double totalAmount,
//     num activeUsers,
//   }) {
//     return new Temp(
//       age: age ?? this.age,
//       id: id ?? this.id,
//       totalUsers: totalUsers ?? this.totalUsers,
//       isAdult: isAdult ?? this.isAdult,
//       totalAmount: totalAmount ?? this.totalAmount,
//       activeUsers: activeUsers ?? this.activeUsers,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Temp{age: $age, id: $id, totalUsers: $totalUsers, isAdult: $isAdult, totalAmount: $totalAmount, activeUsers: $activeUsers}';
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is Temp &&
//           runtimeType == other.runtimeType &&
//           age == other.age &&
//           id == other.id &&
//           totalUsers == other.totalUsers &&
//           isAdult == other.isAdult &&
//           totalAmount == other.totalAmount &&
//           activeUsers == other.activeUsers);
//
//   @override
//   int get hashCode =>
//       age.hashCode ^
//       id.hashCode ^
//       totalUsers.hashCode ^
//       isAdult.hashCode ^
//       totalAmount.hashCode ^
//       activeUsers.hashCode;
//
//   factory Temp.fromMap(Map<String, dynamic> map) {
//     return new Temp(
//       age: map['age'] as DateTime,
//       id: map['id'] as String,
//       totalUsers: map['totalUsers'] as int,
//       isAdult: map['isAdult'] as bool,
//       totalAmount: map['totalAmount'] as double,
//       activeUsers: map['activeUsers'] as num,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_cast
//     return {
//       'age': this.age,
//       'id': this.id,
//       'totalUsers': this.totalUsers,
//       'isAdult': this.isAdult,
//       'totalAmount': this.totalAmount,
//       'activeUsers': this.activeUsers,
//     } as Map<String, dynamic>;
//   }
//
// //</editor-fold>
//
// }

// class Temp {
// //<editor-fold desc="Data Methods" defaultstate="collapsed">
//   const Temp();
//
//   Temp copyWith() {
//     if (true) {
//       return this;
//     }
//
//     return new Temp();
//   }
//
//   @override
//   String toString() {
//     return 'Temp{}';
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is Temp && runtimeType == other.runtimeType);
//
//   @override
//   int get hashCode => 0;
//
//   factory Temp.fromMap(Map<String, dynamic> map) {
//     return new Temp();
//   }
//
//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_cast
//     return {} as Map<String, dynamic>;
//   }
//
// //</editor-fold>
//
// }
