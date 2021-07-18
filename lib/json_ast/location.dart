import 'package:meta/meta.dart';

// ignore_for_file: long-parameter-list

@immutable
class Loc {
  final int? line;
  final int? column;

  const Loc({this.line, this.column});
}

class Segment extends Loc {
  final int? offset;

  const Segment(int? line, int? column, this.offset)
      : super(line: line, column: column);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Segment &&
          runtimeType == other.runtimeType &&
          offset == other.offset;

  @override
  int get hashCode => offset.hashCode;
}

@immutable
class Location {
  final Segment start;
  final Segment end;
  final String? source;

  const Location(this.start, this.end, [this.source]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end &&
          source == other.source;

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ source.hashCode;

  // ignore: prefer_constructors_over_static_methods
  static Location create(int? startLine, int? startColumn, int? startOffset,
      int? endLine, int? endColumn, int? endOffset,
      [String? source]) {
    final startSegment = Segment(startLine, startColumn, startOffset);
    final endSegment = Segment(endLine, endColumn, endOffset);
    return Location(startSegment, endSegment, source);
  }
}
