import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/team_model.dart';

class FeatController extends GetxController {
  var isLoading = false.obs;
  var listProduk = <Team>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduk();
  }

  Future<void> fetchProduk() async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/123/search_all_teams.php?l=English%20Premier%20League",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final model = PremierLeagueModel.fromJson(decoded);
        listProduk.assignAll(model.teams);
      } else {
        Get.snackbar("Gagal", "Gagal memuat data dari server");
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
