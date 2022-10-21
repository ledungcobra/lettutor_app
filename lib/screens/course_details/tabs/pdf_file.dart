import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/widgets/loading.dart';


class PdfFile extends StatefulWidget {
  final String url;

  const PdfFile({Key? key, required this.url}) : super(key: key);

  @override
  State<PdfFile> createState() => _PdfFileState();
}

class _PdfFileState extends State<PdfFile> {
  String? urlPDFPath;
  PDFDocument? doc;
  bool? loaded;
@override
  void initState() {
    PDFDocument.fromURL(widget.url)
    .then((v)=> doc = v)
    .catchError((e)=> print(e));
    super.initState();
}
  @override
  Widget build(BuildContext context) {
    if(doc == null){
      return Loading();
    }
    return PDFViewer(
      document:doc!
    );
  }
}
