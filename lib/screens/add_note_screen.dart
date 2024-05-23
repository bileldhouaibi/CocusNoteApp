import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();

  void _saveNote() async {
    final newNote = Note(
      title: _titleController.text,
      content: _contentController.text,
      image: '', // Assuming image URL is null for simplicity
      tags: _tagsController.text.split(',').map((tag) => tag.trim()).toList(),
      createdDate: DateTime.now().toString(),
      updatedDate: DateTime.now().toString(),
    );

    try {
      await Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add note: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            TextField(
              controller: _tagsController,
              decoration:
                  const InputDecoration(labelText: 'Tags (comma separated)'),
            ),
          ],
        ),
      ),
    );
  }
}
