import 'package:cocus_note_app/models/notes_model.dart';
import 'package:cocus_note_app/provisers/note_provider.dart';
import 'package:cocus_note_app/screens/edit_note_screen.dart';
import 'package:cocus_note_app/services/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:html' as html;

import 'package:provider/provider.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  NoteDetailScreen({required this.note});

  final PdfService _pdfService = PdfService();

  void _printNote() async {
    final pdfData = await _pdfService.generatePdf(note);
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
  }

  void _downloadPdf() async {
    final pdfData = await _pdfService.generatePdf(note);
    final pdfBlob = html.Blob([pdfData], 'application/pdf');
    final pdfUrl = html.Url.createObjectUrlFromBlob(pdfBlob);
    final anchor = html.AnchorElement(href: pdfUrl);
    anchor.setAttribute('download', '${note.title}.pdf');
    anchor.click();
    html.Url.revokeObjectUrl(pdfUrl);
  }

  void _deleteNote(BuildContext context) {
    Provider.of<NotesProvider>(context, listen: false).deleteNote(note.id);
    Navigator.pop(context);
  }

  void _linkNoteDialog(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) {
        String? selectedNoteId;
        return AlertDialog(
          title: Text('Link Note'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                hint: Text('Select Note to Link'),
                value: selectedNoteId,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedNoteId = newValue;
                  });
                },
                items: notesProvider.notes
                    .where((n) => n.id != note.id)
                    .map<DropdownMenuItem<String>>((Note note) {
                  return DropdownMenuItem<String>(
                    value: note.id,
                    child: Text(note.title),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedNoteId != null) {
                  notesProvider.linkNotes(note.id, selectedNoteId!);
                  Navigator.of(ctx).pop();
                }
              },
              child: Text('Link'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    final linkedNotes = notesProvider.getLinkedNotes(note.id);

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
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _printNote,
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadPdf,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteNote(context),
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
              SizedBox(height: 20),
              if (note.image != null)
                Center(
                  child: Image.memory(
                    note.image!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 20),
              Text(
                note.content,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              if (note.tags.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  children:
                      note.tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
              SizedBox(height: 20),
              Text(
                'Created: ${note.createdDate}',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                'Updated: ${note.updatedDate}',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 20),
              Text(
                'Linked Notes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: linkedNotes.map((linkedNote) {
                  return ListTile(
                    title: Text(linkedNote.title),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            NoteDetailScreen(note: linkedNote),
                      ));
                    },
                  );
                }).toList(),
              ),
              TextButton(
                onPressed: () => _linkNoteDialog(context),
                child: Text('Link Another Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
