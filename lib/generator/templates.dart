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
}\n''';
  }
}
