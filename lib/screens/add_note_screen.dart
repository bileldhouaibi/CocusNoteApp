import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  Uint8List? _pickedImage;
  List<String> _tags = [];

  Future<void> _pickImage() async {
    Uint8List? picked = await ImagePickerWeb.getImageAsBytes();
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            _pickedImage != null
                ? Image.memory(_pickedImage!,
                    height: 150, width: 150, fit: BoxFit.cover)
                : Container(height: 150, width: 150, color: Colors.grey[300]),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _tagController,
              decoration: InputDecoration(
                labelText: 'Tag',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTag,
              child: Text('Add Tag'),
            ),
            Wrap(
              spacing: 8.0,
              children: _tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        onDeleted: () => _removeTag(tag),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final note = Note(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  content: _contentController.text,
                  image: _pickedImage,
                  tags: _tags,
                );
                Provider.of<NotesProvider>(context, listen: false)
                    .addNote(note);
                Navigator.pop(context);
              },
              child: Text('Add Note'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
