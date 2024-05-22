import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/screens/edit_note_screen.dart';

import 'package:flutter/material.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  NoteDetailScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditNoteScreen(note: note),
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              if (note.image != null)
                Image.memory(note.image!,
                    height: 150, width: 150, fit: BoxFit.cover),
              SizedBox(height: 10),
              Text(
                note.content,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
