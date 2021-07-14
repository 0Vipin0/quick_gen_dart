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

    group("hash code Tests", () {
      test("Empty hash code Test", () {
        final DataClassGenerator dataClassGenerator =
            DataClassGenerator(className: className, inputs: []);
        const String expectedHashCode = '''
@override
int get hashCode => 0;''';

        final String generatedHashCode = dataClassGenerator.getHashCode();

        expect(expectedHashCode, generatedHashCode);
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

        expect(expectedHashCode, generatedHashCode);
      });
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

void equalityTests(String className, List<Map<String, String>> inputs) {
  return group("Equality Tests", () {
    test("Empty equality Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: []);
      const String expectedEquality = '''
@override
bool operator == (Object other) =>
identical(this, other) ||
(other is Temp &&
runtimeType == other.runtimeType);''';
      final generatedEquality = dataClassGenerator.getEquality();
      expect(expectedEquality, generatedEquality);
    });

    test("equality Test", () {
      final DataClassGenerator dataClassGenerator =
          DataClassGenerator(className: className, inputs: inputs);
      const String expectedEquality = '''
@override
bool operator == (Object other) =>
identical(this, other) ||
(other is Temp &&
runtimeType == other.runtimeType &&
age == other.age &&
id == other.id &&
totalUsers == other.totalUsers &&
isAdult == other.isAdult &&
totalAmount == other.totalAmount &&
activeUsers == other.activeUsers);''';
      final generatedEquality = dataClassGenerator.getEquality();
      expect(expectedEquality, generatedEquality);
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
  return 'Temp{}';
}''';
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
}''';
      final String generatedToString = dataClassGenerator.getToString();

      expect(expectedToString, generatedToString);
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
