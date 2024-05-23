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
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      final note = _notes.removeAt(noteIndex);
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

  void sortNotesByDate({bool ascending = true}) {
    _notes.sort((a, b) => ascending
        ? a.updatedDate.compareTo(b.updatedDate)
        : b.updatedDate.compareTo(a.updatedDate));
    notifyListeners();
  }

  void linkNotes(String noteId1, String noteId2) {
    final note1 = _notes.firstWhere((note) => note.id == noteId1);
    final note2 = _notes.firstWhere((note) => note.id == noteId2);

    if (!note1.linkedNotes.contains(noteId2)) {
      note1.linkedNotes.add(noteId2);
    }
    if (!note2.linkedNotes.contains(noteId1)) {
      note2.linkedNotes.add(noteId1);
    }
    notifyListeners();
  }

  void unlinkNotes(String noteId1, String noteId2) {
    final note1 = _notes.firstWhere((note) => note.id == noteId1);
    final note2 = _notes.firstWhere((note) => note.id == noteId2);

    note1.linkedNotes.remove(noteId2);
    note2.linkedNotes.remove(noteId1);
    notifyListeners();
  }

  List<Note> getLinkedNotes(String noteId) {
    final note = _notes.firstWhere((note) => note.id == noteId);
    return note.linkedNotes
        .map((id) => _notes.firstWhere((note) => note.id == id))
        .toList();
  }
}
