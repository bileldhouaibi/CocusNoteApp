import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatedNotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Updated Notes History'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              notesProvider.clearUpdatedNotesHistory();
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: notesProvider.updatedNotes.length,
        itemBuilder: (ctx, index) {
          final note = notesProvider.updatedNotes[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(note.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(
                note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
          );
        },
      ),
    );
  }
}