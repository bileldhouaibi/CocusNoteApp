import 'package:cocus_note_app/models/notes_model.dart';
import 'package:flutter/foundation.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _deletedNotes = [];
  List<Note> _updatedNotes = [];
  Map<String, List<Note>> _noteVersions = {};

  List<Note> get notes => _notes;
  List<Note> get deletedNotes => _deletedNotes;
  List<Note> get updatedNotes => _updatedNotes;

  void addNote(Note note) {
    _notes.add(note);
    _noteVersions[note.id] = [note];
    notifyListeners();
  }

  void deleteNote(String id) {
    final note =
        _notes.firstWhere((note) => note.id == id, orElse: () => null as Note);
    if (note != null) {
      _notes.remove(note);
      _deletedNotes.add(note);
      notifyListeners();
    }
  }

  void updateNote(Note updatedNote) {
    final index = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      _updatedNotes.add(_notes[index]);
      _notes[index] = updatedNote;
      _noteVersions[updatedNote.id]?.add(updatedNote);
      notifyListeners();
    }
  }

  List<String> getAllTags() {
    return _notes.expand((note) => note.tags).toSet().toList();
  }

  List<Note> getNoteVersions(String id) {
    return _noteVersions[id] ?? [];
  }

  void clearDeletedNotesHistory() {
    _deletedNotes.clear();
    notifyListeners();
  }

  void clearUpdatedNotesHistory() {
    _updatedNotes.clear();
    notifyListeners();
  }

  List<Note> searchNotes(String query) {
    return _notes.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<Note> filterNotesByTag(String? tag) {
    if (tag == null) {
      return _notes;
    }
    return _notes.where((note) => note.tags.contains(tag)).toList();
  }
}
