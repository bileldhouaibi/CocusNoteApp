import 'package:cocus_note_app/models/notes_model.dart';
import 'package:flutter/foundation.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void updateNote(Note updatedNote) {
    final index = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      notifyListeners();
    }
  }

  List<Note> searchNotes(String query) {
    return _notes.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<String> getAllTags() {
    return _notes.expand((note) => note.tags).toSet().toList();
  }

  List<Note> filterNotesByTag(String? tag) {
    if (tag == null) {
      return _notes;
    }
    return _notes.where((note) => note.tags.contains(tag)).toList();
  }
}
