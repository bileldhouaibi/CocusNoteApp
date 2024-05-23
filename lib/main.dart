import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:cocus_note_app/screens/deleted_note_screen.dart';
import 'package:cocus_note_app/screens/notes_list_screen.dart';
import 'package:cocus_note_app/screens/updated_note_sccreen.dart';
import 'package:cocus_note_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: themeData,
        home: NotesListScreen(),
        routes: {
          '/deleted-notes': (context) => DeletedNotesScreen(),
          '/updated-notes': (context) => UpdatedNotesScreen(),
        },
      ),
    );
  }
}
