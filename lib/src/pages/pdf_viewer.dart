import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewer extends StatefulWidget {
  static const routeName = '/pdf-viewer';

  const PDFViewer({
    super.key,
  });

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        // or use `network` constructor to load a PDF from a URL
        filePath: 'https://drive.google.com/file/d/1W0ODUlfJDdTEcYXN3D0Gplyh6PiVzLuV/view?usp=sharing',
        onRender: (_pages) {
          // Do something when the PDF is rendered
        },
        onError: (error) {
          // Do something when there is an error rendering the PDF
        },
      ),
    );
  }
}
