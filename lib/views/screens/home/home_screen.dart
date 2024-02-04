import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:practice/savepdf.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            ElevatedButton(
              onPressed: createPdf,
              child: Text("Create PDF"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createPdf() async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();

    final String name = _nameController.text;
    final String email = _emailController.text;
    final String address = _addressController.text;

    page.graphics.drawString("Name: $name", PdfStandardFont(PdfFontFamily.helvetica, 18));
    page.graphics.drawString("Email: $email", PdfStandardFont(PdfFontFamily.helvetica, 18));
    page.graphics.drawString("Address: $address", PdfStandardFont(PdfFontFamily.helvetica, 18));

    final List<int> bytes = await document.save();
    document.dispose();

    savePdfFile(bytes, "Output.pdf");

    ///firebase
    final String fileName = "Output.pdf";
    await savePdfFile(bytes, fileName);
    await uploadPdfToFirebaseStorage(bytes, fileName);
  }


  Future<void> uploadPdfToFirebaseStorage(List<int> bytes, String fileName) async {
    try {
      final Uint8List data = Uint8List.fromList(bytes);
      final Reference reference = FirebaseStorage.instance.ref().child(fileName);
      await reference.putData(data);
      print("PDF file uploaded to Firebase Storage.");
    } catch (e) {
      print("Error uploading PDF file to Firebase Storage: $e");
    }
  }
}
