import 'package:apotek_habibi/style/color.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class UserGuidePDFWidget extends StatefulWidget {
  const UserGuidePDFWidget({Key? key}) : super(key: key);

  @override
  _UserGuidePDFWidgetState createState() => _UserGuidePDFWidgetState();
}

class _UserGuidePDFWidgetState extends State<UserGuidePDFWidget> {
  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/userguide.pdf'),
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Warna.primarybackground,
        appBar: AppBar(
          backgroundColor: Warna.primarybackground,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
            'User Manual',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: PdfView(
            controller: pdfController,
          ),
        ),
      ),
    );
  }
}
