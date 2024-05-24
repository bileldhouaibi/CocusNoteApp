import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotesProvider', () {
    late NotesProvider notesProvider;

    setUp(() {
      notesProvider = NotesProvider();
    });

    test('Initial state is empty', () {
      expect(notesProvider.notes, []);
    });

    test('Add note', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        content: 'This is a test note.',
        tags: ['tag1'],
        isArchived: false,
        createdDate: DateTime.now().toIso8601String(),
        updatedDate: DateTime.now().toIso8601String(),
      );
      notesProvider.addNoteForTest(note);
      expect(notesProvider.notes.length, 1);
      expect(notesProvider.notes.first.title, 'Test Note');
    });

    test('Delete note', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        content: 'This is a test note.',
        tags: ['tag1'],
        isArchived: false,
        createdDate: DateTime.now().toIso8601String(),
        updatedDate: DateTime.now().toIso8601String(),
      );
      notesProvider.addNoteForTest(note);
      notesProvider.deleteNoteForTest('1');
      expect(notesProvider.notes.length, 0);
    });

    test('Filter notes by date', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        content: 'This is a test note.',
        tags: ['tag1'],
        isArchived: false,
        createdDate: DateTime.now().toIso8601String(),
        updatedDate: DateTime.now().toIso8601String(),
      );
      notesProvider.addNoteForTest(note);
      notesProvider.filterByDate(DateTime.now());
      expect(notesProvider.notes.length, 1);
    });
  });
}
