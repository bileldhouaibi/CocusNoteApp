import 'package:cocus_note_app/utils/helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notes_model.g.dart';

@JsonSerializable()
class Note {
  @JsonKey(name: '_id')
  String? id;
  String title;
  String content;
  String? image;
  List<String> tags;
  bool? isArchived;
  @JsonKey(name: 'createdAt')
  String? createdDate;
  @JsonKey(name: 'updatedAt')
  String? updatedDate;

  Note({
    this.id,
    required this.title,
    required this.content,
    this.image,
    this.tags = const [],
    this.isArchived,
    this.createdDate,
    this.updatedDate,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
  void decryptContent(EncryptionHelper helper) {
    content = helper.decrypt(content);
  }

  void encryptContent(EncryptionHelper helper) {
    content = helper.encrypt(content);
  }
}
