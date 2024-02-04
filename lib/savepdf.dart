import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> savePdfFile(List<int> bytes, String fileName)async{
  try{
    final directory = await getApplicationDocumentsDirectory();
    if(directory != null){
      final path = (await getExternalStorageDirectory())!.path;
      final file = File("$path/$fileName");
      // ///-----------firebase save-----------
      // final Reference reference = FirebaseStorage.instance.ref().child(fileName);
      // await reference.putFile(file);
      // print("PDF file uploaded to Firebase Storage.");


      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open("$path/$fileName");
    }else{
      print("Error: Application documents directory not found.");
    }
  }catch(e){
    print("error $e");
  }
}
// Future<void> uploadPdfToFirebaseStorage(String fileName) async{
//   try {
//     final File file = File("$path/$fileName");
//     final Reference reference = FirebaseStorage.instance.ref().child(fileName);
//     await reference.putFile(file);
//     print("PDF file uploaded to Firebase Storage.");
//   } catch (e) {
//     print("Error uploading PDF file to Firebase Storage: $e");
//   }
// }

