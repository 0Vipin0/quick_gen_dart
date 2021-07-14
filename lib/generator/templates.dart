import 'package:quick_gen_dart/generator/constants.dart';

class Templates {
  static String toStringTemplate({
    required String className,
    required String content,
  }) {
    return '''
$OVERRIDE
String toString() {
\treturn '$className{$content}';
}''';
  }

  static String toEqualityTemplate({
    required String className,
    required String content,
  }) {
    return '''
$OVERRIDE
bool operator == (Object other) =>
\tidentical(this, other) ||
\t(other is Temp &&
\truntimeType == other.runtimeType$content);''';
  }

  static String toHashCodeTemplate({
    required String className,
    required String content,
  }) {
    return '''
$OVERRIDE
int get hashCode =>$content;''';
  }

  static String toConstructorTemplate({
    required String className,
    required String content,
    required bool shouldAddConst,
  }) {
    return '''
${shouldAddConst ? "const " : ""}$className($content);''';
  }

  static String toCopyWithTemplate({
    required String className,
    required String content,
    required String parameters,
  }) {
    return '''
$className copyWith($parameters) => $className($content);''';
  }

  static String toMapTemplate({required String content}) {
    return '''
Map<String, dynamic> toMap() => <String, dynamic>{$content};''';
  }

  static String toFromMapTemplate(
      {required String className, required String content}) {
    return '''
factory $className.fromMap(Map<String, dynamic> map) => $className($content);''';
  }
}
