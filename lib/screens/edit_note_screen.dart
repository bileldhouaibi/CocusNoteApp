import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagController;
  Uint8List? _pickedImage;
  Uint8List? _existingImage;
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _tagController = TextEditingController();
    _existingImage = widget.note.image;
    _tags = widget.note.tags;
  }

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
        title: Text('Edit Note'),
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
                : (_existingImage != null
                    ? Image.memory(_existingImage!,
                        height: 150, width: 150, fit: BoxFit.cover)
                    : Container(
                        height: 150, width: 150, color: Colors.grey[300])),
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
                final updatedNote = Note(
                  id: widget.note.id,
                  title: _titleController.text,
                  content: _contentController.text,
                  image: _pickedImage ?? _existingImage,
                  tags: _tags,
                );
                Provider.of<NotesProvider>(context, listen: false)
                    .updateNote(updatedNote);
                Navigator.pop(context);
              },
              child: Text('Update Note'),
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
