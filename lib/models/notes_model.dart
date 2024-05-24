import 'package:intl/intl.dart';
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
  DateTime parseDate(String dateStr) {
    try {
      return DateFormat('EEEE, dd \'de\' MMMM \'de\' yyyy', 'pt_BR')
          .parse(dateStr);
    } catch (e) {
      return DateTime.now(); // Fallback in case of parsing error
    }
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

  DateTime get createdDateTime => parseDate(createdDate!);
  DateTime get updatedDateTime => parseDate(updatedDate!);
}
