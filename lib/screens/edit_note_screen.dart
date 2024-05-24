import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagsController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _tagsController = TextEditingController(text: widget.note.tags.join(', '));
    super.initState();
  }

  void _saveNote() async {
    final updatedNote = Note(
      id: widget.note.id,
      title: _titleController.text,
      content: _contentController.text,
      image: widget.note.image,
      tags: _tagsController.text.split(',').map((tag) => tag.trim()).toList(),
      createdDate: widget.note.createdDate,
      updatedDate: DateTime.now().toIso8601String(),
      isArchived: widget.note.isArchived,
    );

    try {
      await Provider.of<NotesProvider>(context, listen: false)
          .updateNote(updatedNote);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update note: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        // Use Consumer here

        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Conten'),
                  maxLines: 5,
                ),
                TextField(
                  controller: _tagsController,
                  decoration: const InputDecoration(
                      labelText: 'Tags comma to separated'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
