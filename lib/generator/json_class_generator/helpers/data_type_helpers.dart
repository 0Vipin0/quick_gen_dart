import 'dart:math';

import 'package:quick_gen_dart/json_ast/json_ast.dart';

const Map<String, bool> PRIMITIVE_TYPES = {
  'int': true,
  'double': true,
  'String': true,
  'bool': true,
  'DateTime': false,
  'List<DateTime>': false,
  'List<int>': true,
  'List<double>': true,
  'List<String>': true,
  'List<bool>': true,
  'Null': true,
};

bool isPrimitiveType(String typeName) {
  final bool? isPrimitive = PRIMITIVE_TYPES[typeName];
  if (isPrimitive == null) {
    return false;
  }
  return isPrimitive;
}

String getTypeName(dynamic obj) {
  if (obj is String) {
    return 'String';
  } else if (obj is int) {
    return 'int';
  } else if (obj is double) {
    return 'double';
  } else if (obj is bool) {
    return 'bool';
  } else if (obj == null) {
    return 'Null';
  } else if (obj is List) {
    return 'List';
  } else {
    return 'Class';
  }
}

bool isLiteralDouble(Node astNode) {
  final _pattern = RegExp(r"([0-9]+)\.{0,1}([0-9]*)e(([-0-9]+))");
  if (astNode is LiteralNode) {
    final LiteralNode literalNode = astNode;
    final bool containsPoint = literalNode.raw?.contains('.') ?? false;
    final bool containsExponent = literalNode.raw?.contains('e') ?? false;
    if (containsPoint || containsExponent) {
      bool isDouble = containsPoint;
      if (containsExponent) {
        final matches = _pattern.firstMatch(literalNode.raw ?? "");
        if (matches != null) {
          final String? integer = matches[1];
          final String? comma = matches[2];
          final String? exponent = matches[3];
          isDouble = isDoubleWithExponential(integer, comma, exponent);
        }
      }
      return isDouble;
    }
  }
  return false;
}

bool isDoubleWithExponential(String? integer, String? comma, String? exponent) {
  final integerNumber = int.tryParse(integer!) ?? 0;
  final exponentNumber = int.tryParse(exponent!) ?? 0;
  final commaNumber = int.tryParse(comma!) ?? 0;
  if (exponentNumber == 0) {
    return commaNumber > 0;
  }
  if (exponentNumber > 0) {
    return exponentNumber < comma.length && commaNumber > 0;
  }
  return commaNumber > 0 ||
      ((integerNumber.toDouble() * pow(10, exponentNumber)).remainder(1) > 0);
}
