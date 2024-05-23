// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      id: json['_id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isArchived: json['isArchived'] as bool?,
      createdDate: json['createdAt'] as String?,
      updatedDate: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'tags': instance.tags,
      'isArchived': instance.isArchived,
      'createdAt': instance.createdDate,
      'updatedAt': instance.updatedDate,
    };
