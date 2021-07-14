import 'package:quick_gen_dart/generator/constants.dart';

class Templates {
  static String toStringTemplate({
    required String className,
    required String content,
  }) {
    return '''
$OVERRIDE
String toString() {
  return '$className{$content}';
}''';
  }

  static String toEqualityTemplate({
    required String className,
    required String content,
  }) {
    return '''
$OVERRIDE
bool operator == (Object other) =>
  identical(this, other) ||
  (other is Temp &&
  runtimeType == other.runtimeType$content);''';
  }

  static String toHashCodeTemplate({
    required String className,
    required String content,
  }) {
    return '''
$OVERRIDE
int get hashCode =>$content;''';
  }
}
