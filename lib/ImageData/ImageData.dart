import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageData {
  static Future<String> getImageURL(String image) async {
    String imageURL = await FirebaseStorage.instance
        .ref()
        .child(image)
        .getDownloadURL();
    return imageURL;
  }

  static Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await FirebaseStorage.instance.ref("gambar/$fileName").putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}