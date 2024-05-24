import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:cocus_note_app/screens/notes_list_screen.dart';
import 'package:cocus_note_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => NotesProvider(),
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: themeData,
        home: NotesListScreen(),
        onGenerateRoute: (settings) {
          if (settings.name?.startsWith('/note-detail/') == true) {
            final noteId = settings.name?.replaceFirst('/note-detail/', '');
            if (noteId != null) {}
          }
          return null;
        },
      ),
    );
  }
}
