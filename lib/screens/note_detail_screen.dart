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
                'Previous Versions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...Provider.of<NotesProvider>(context)
                  .getNoteVersions(note.id)
                  .map((version) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    version.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
