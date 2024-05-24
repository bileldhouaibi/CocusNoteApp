import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/services/notes_services.dart';
import 'package:flutter/foundation.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  Note? _selectedNote;
  final NoteService _noteService = NoteService();

  List<Note> get notes => _filteredNotes.isEmpty ? _notes : _filteredNotes;
  Note? get selectedNote => _selectedNote;

  Future<void> fetchAndSetNotes() async {
    try {
      _notes = await _noteService.fetchNotes();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchNoteDetails(String id) async {
    try {
      _selectedNote = await _noteService.fetchNoteDetails(id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await _noteService.addNote(note);
      _notes.add(note);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _noteService.deleteNote(id);
      _notes.removeWhere((note) => note.id == id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      final statusCode = await _noteService.updateNote(note);
      if (statusCode == 200 || statusCode == 204) {
        final index = _notes.indexWhere((n) => n.id == note.id);
        if (index >= 0) {
          _notes[index] = note;
          notifyListeners();
        }
      }
    } catch (error) {
      throw error;
    }
  }

  void searchNotes(String query) {
    _filteredNotes = _notes
        .where((note) =>
            note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void filterByTag(String tag) {
    _filteredNotes = _notes.where((note) => note.tags.contains(tag)).toList();
    notifyListeners();
  }

  void filterByDate(DateTime selectedDate) {
    _filteredNotes = _notes.where((note) {
      final noteDate = note.createdDateTime;
      return noteDate.year == selectedDate.year &&
          noteDate.month == selectedDate.month &&
          noteDate.day == selectedDate.day;
    }).toList();
    notifyListeners();
  }

  void clearFilters() {
    _filteredNotes = [];
    notifyListeners();
  }
}
