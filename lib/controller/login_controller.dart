import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';
import '../routes.dart';

class LoginController extends GetxController {
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();
  var isLoading = false.obs;

  Future<void> login() async {
    final username = txtUsername.text.trim();
    final password = txtPassword.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Username dan password tidak boleh kosong",
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

    
      final url = Uri.parse("https://mediadwi.com/api/latihan/login");

      final response = await http.post(
        url,
        body: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final model = loginmodelFromJson(response.body);

        if (model.status) {
          Get.snackbar(
            "Berhasil",
            model.message.isNotEmpty ? model.message : "Login berhasil",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );

          // Pindah ke MenuDrawer & Hapus Riwayat Login dari backstack
          Get.offNamed(Routes.menuDrawer);
        } else {
          Get.snackbar(
            "Gagal",
            model.message.isNotEmpty ? model.message : "Username atau password salah",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Server error code: ${response.statusCode}",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menghubungi server: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    txtUsername.dispose();
    txtPassword.dispose();
    super.onClose();
  }
}
