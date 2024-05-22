import 'dart:typed_data';

class Note {
  String id;
  String title;
  String content;
  Uint8List? image;
  List<String> tags;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    this.tags = const [],
  });
}
