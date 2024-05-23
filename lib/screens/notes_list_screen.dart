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
  String _searchQuery = '';
  String? _selectedTag;

  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).fetchAndSetNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    final notes = notesProvider.notes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNoteScreen(),
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      notesProvider.clearFilters();
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                notesProvider.searchNotes(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedTag,
                    hint: Text('Filter by Tag'),
                    onChanged: (String? newTag) {
                      setState(() {
                        _selectedTag = newTag;
                      });
                      if (newTag != null) {
                        notesProvider.filterByTag(newTag);
                      } else {
                        notesProvider.clearFilters();
                      }
                    },
                    items: notesProvider.notes
                        .expand((note) => note.tags)
                        .toSet()
                        .map<DropdownMenuItem<String>>((String tag) {
                      return DropdownMenuItem<String>(
                        value: tag,
                        child: Text(tag),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    notesProvider.sortByMostRecent();
                  },
                  child: Text('Most Recent'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    notesProvider.sortByOldest();
                  },
                  child: Text('Oldest'),
                ),
              ],
            ),
          ),
          Expanded(
            child: notes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: notes.length,
                    itemBuilder: (ctx, index) {
                      final note = notes[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Row(
                            children: [
                              Icon(Icons.title,
                                  color: Theme.of(context).colorScheme.primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  note.title,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.description,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      note.content,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.date_range, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text(
                                    'Created: ${note.createdDate}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.update, color: Colors.orange),
                                  SizedBox(width: 8),
                                  Text(
                                    'Updated: ${note.updatedDate}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Wrap(
                                spacing: 6.0,
                                runSpacing: -8.0,
                                children: note.tags.map((tag) {
                                  return Chip(
                                    label: Text(tag),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.grey),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditNoteScreen(note: note),
                                  ));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  try {
                                    await notesProvider.deleteNote(note.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Note deleted')),
                                    );
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Failed to delete note: $error')),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailScreen(noteId: note.id!),
                            ));
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
