import 'dart:typed_data';

class Note {
  String id;
  String title;
  String content;
  Uint8List? image;
  List<String> tags;
  List<NoteVersion> versions;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    this.tags = const [],
    this.versions = const [],
  });
}

class NoteVersion {
  final String title;
  final String content;
  final Uint8List? image;
  final List<String> tags;
  final DateTime timestamp;

  NoteVersion({
    required this.title,
    required this.content,
    this.image,
    required this.tags,
    required this.timestamp,
  });
}
