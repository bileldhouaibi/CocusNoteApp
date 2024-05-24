import 'package:cocus_note_app/services/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../provisers/note_provider.dart';

class NoteDetailScreen extends StatelessWidget {
  final String noteId;

  const NoteDetailScreen({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              final notesProvider =
                  Provider.of<NotesProvider>(context, listen: false);
              final note = notesProvider.selectedNote!;
              final pdf = await generateNotePdf(note);
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => pdf.save(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final notesProvider =
                  Provider.of<NotesProvider>(context, listen: false);
              final note = notesProvider.selectedNote!;
              final pdf = await generateNotePdf(note);
              await Printing.sharePdf(
                bytes: await pdf.save(),
                filename: '${note.title}.pdf',
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<NotesProvider>(context, listen: false)
            .fetchNoteDetails(noteId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('An error occurred!'));
          } else {
            return Consumer<NotesProvider>(
              builder: (ctx, notesProvider, child) {
                final note = notesProvider.selectedNote!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Markdown(
                          data: note.content,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: -8.0,
                        children: note.tags.map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: Colors.blue.shade100,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.date_range, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            'Created: ${note.createdDate}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.update, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Updated: ${note.updatedDate}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
