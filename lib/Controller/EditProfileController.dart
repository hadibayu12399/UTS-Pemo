import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_pemo/Model/models.dart';

class EditProfileController extends GetxController {
  final editNamaController = TextEditingController();
  final editNotelpController = TextEditingController();

  bool validateSignUp() {
    if (editNamaController.text.isEmpty || editNotelpController.text.isEmpty) {
      Get.dialog(
        AlertDialog(
          content: const Text("Masih ada kolom yang kosong!"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Tutup"),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }
}
