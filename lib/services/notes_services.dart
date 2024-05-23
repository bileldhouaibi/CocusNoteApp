import 'dart:convert';

import 'package:cocus_note_app/models/notes_model.dart';
import 'package:dio/dio.dart';

class NoteService {
  final Dio _dio = Dio();

  Future<List<Note>> fetchNotes() async {
    try {
      final response =
          await _dio.get('https://notes-demo-gray.vercel.app/notes');
      if (response.statusCode == 200) {
        // Check if response.data is a string and parse it
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        List<Note> notes =
            (data as List).map((note) => Note.fromJson(note)).toList();
        return notes;
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load notes: $e');
    }
  }

  Future<void> addNote(Note note) async {
    try {
      final response = await _dio.post(
        'https://notes-demo-gray.vercel.app/notes',
        data: {
          'title': note.title,
          'content': note.content,
          'tags': note.tags,
          'createdAt': note.createdDate,
          'updatedAt': note.updatedDate,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['id'] != null) {
        print('Note added successfully');
      } else {
        throw Exception('Failed to add note');
      }
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      final response =
          await _dio.delete('https://notes-demo-gray.vercel.app/notes/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete note: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  Future<int> updateNote(Note note) async {
    try {
      final response = await _dio.put(
        'https://notes-demo-gray.vercel.app/notes/${note.id}',
        data: {
          'title': note.title,
          'content': note.content,
          'tags': note.tags,
          'updatedAt': note.updatedDate,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.statusCode!;
    } catch (e) {
      print(e);
      throw Exception('Failed to update note: $e');
    }
  }

  Future<Note> fetchNoteDetails(String id) async {
    try {
      final response = await _dio
          .get('https://notes-demo-gray.vercel.app/notes/$id/details');
      if (response.statusCode == 200) {
        return Note.fromJson(response.data);
      } else {
        throw Exception('Failed to load note details');
      }
    } catch (e) {
      throw Exception('Failed to load note details: $e');
    }
  }
}
