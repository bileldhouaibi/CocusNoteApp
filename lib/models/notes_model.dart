import 'dart:typed_data';

class Note {
  String id;
  String title;
  String content;
  Uint8List? image;
  List<String> tags;
  DateTime createdDate;
  DateTime updatedDate;
  List<String> linkedNotes;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    this.tags = const [],
    required this.createdDate,
    required this.updatedDate,
    this.linkedNotes = const [],
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.image == image &&
        other.tags == tags &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate &&
        other.linkedNotes == linkedNotes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        image.hashCode ^
        tags.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode ^
        linkedNotes.hashCode;
  }
}
