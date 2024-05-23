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
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    List<Note> notes = _selectedTag == null
        ? notesProvider.notes
        : notesProvider.notes
            .where((note) => note.tags.contains(_selectedTag!))
            .toList();

    if (_searchQuery.isNotEmpty) {
      notes = notes.where((note) {
        return note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    List<String> allTags = notesProvider.getAllTags();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).pushNamed('/deleted-notes');
            },
          ),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              Navigator.of(context).pushNamed('/updated-notes');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
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
          ),
          Expanded(
            child: ListView.builder(
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        Wrap(
                          spacing: 6.0,
                          children: note.tags
                              .map((tag) => Chip(label: Text(tag)))
                              .toList(),
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
          ),
        ],
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
