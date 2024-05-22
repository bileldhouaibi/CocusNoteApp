import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:cocus_note_app/screens/add_note_screen.dart';
import 'package:cocus_note_app/screens/edit_note_screen.dart';
import 'package:cocus_note_app/screens/note_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesListScreen extends StatefulWidget {
  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  String? _selectedTag;

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    List<Note> notes = _selectedTag == null
        ? notesProvider.notes
        : notesProvider.notes
            .where((note) => note.tags.contains(_selectedTag!))
            .toList();

    List<String> allTags =
        notesProvider.notes.expand((note) => note.tags).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          DropdownButton<String>(
            value: _selectedTag,
            hint: Text('Filter by Tag'),
            onChanged: (String? newTag) {
              setState(() {
                _selectedTag = newTag;
              });
            },
            items: allTags.map<DropdownMenuItem<String>>((String tag) {
              return DropdownMenuItem<String>(
                value: tag,
                child: Text(tag),
              );
            }).toList(),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _selectedTag = null;
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: notes.length,
        itemBuilder: (ctx, index) {
          final note = notes[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(note.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Wrap(
                    spacing: 6.0,
                    children:
                        note.tags.map((tag) => Chip(label: Text(tag))).toList(),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailScreen(note: note),
                ));
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditNoteScreen(note: note),
                      ));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      notesProvider.deleteNote(note.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNoteScreen(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
