import 'package:pdf/widgets.dart' as pw;
import '../models/notes_model.dart';
import 'package:pdf/pdf.dart';

Future<pw.Document> generateNotePdf(Note note) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Container(
          padding: pw.EdgeInsets.all(16.0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                note.title,
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                note.content,
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 16),
              pw.Wrap(
                spacing: 6.0,
                runSpacing: -8.0,
                children: note.tags.map((tag) {
                  return pw.Container(
                    padding: pw.EdgeInsets.all(4.0),
                    color: PdfColors.lightBlue,
                    child: pw.Text(tag),
                  );
                }).toList(),
              ),
              pw.SizedBox(height: 16),
              pw.Row(
                children: [
                  pw.Icon(
                    pw.IconData(0xe3b6),
                    color: PdfColors.green,
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    'Created: ${note.createdDate}',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                children: [
                  pw.Icon(
                    pw.IconData(0xe873),
                    color: PdfColors.orange,
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    'Updated: ${note.updatedDate}',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  return pdf;
}
