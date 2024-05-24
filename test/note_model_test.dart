import 'package:cocus_note_app/models/notes_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Note Model', () {
    test('Note creation', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        content: 'This is a test note.',
      );

      expect(note.id, '1');
      expect(note.title, 'Test Note');
      expect(note.content, 'This is a test note.');
    });
  });
}
