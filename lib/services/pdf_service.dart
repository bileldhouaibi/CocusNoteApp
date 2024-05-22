import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:notes_app/models/note_model.dart';

class PdfService {
  Future<Uint8List> generatePdf(Note note) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(note.title,
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              if (note.image != null)
                pw.Image(
                  pw.MemoryImage(note.image!),
                  height: 150,
                  width: 150,
                ),
              pw.SizedBox(height: 20),
              pw.Text(note.content, style: pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 20),
              if (note.tags.isNotEmpty)
                pw.Wrap(
                  spacing: 8.0,
                  children: note.tags
                      .map((tag) => pw.Container(
                            padding: pw.EdgeInsets.all(4),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Text(tag),
                          ))
                      .toList(),
                ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
