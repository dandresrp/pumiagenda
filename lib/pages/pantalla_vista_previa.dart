import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PantallaVistaPrevia extends StatelessWidget {
  final String pdfPath;

  const PantallaVistaPrevia({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: 600,
            child: PDFView(
              filePath: pdfPath,
            ),
          ),
        ),
      ),
    );
  }
}
