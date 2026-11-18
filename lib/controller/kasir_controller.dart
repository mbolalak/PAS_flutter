import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/kasir_model.dart';

class KasirController extends GetxController {
  var isLoading = false.obs;
  var listMenu = <ProdukModel>[].obs;

  // Melacak keranjang belanja: {id_produk: jumlah_beli}
  var pesanan = <int, int>{}.obs;

  // Parameter Matematika Kasir
  var diskonPersen = 10.0.obs; // Diskon 10% jika belanja >= 100.000
  var ppnPersen = 11.0.obs;    // PPN 11%
  final txtBayar = TextEditingController();
  var kembalian = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadStaticProduk();
  }

  void loadStaticProduk() {
    isLoading.value = true;

    listMenu.assignAll([
      ProdukModel(
        id: 1,
        namaProduk: "Nasi Goreng Spesial",
        harga: 25000,
        description: "Nasi goreng bumbu rempah dengan telur mata sapi, ayam suwir, dan kerupuk.",
        imageUrl: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/730/header.jpg",
      ),
      ProdukModel(
        id: 2,
        namaProduk: "Ayam Bakar Madu",
        harga: 30000,
        description: "Ayam bakar olesan madu murni lengkap dengan sambal terasi dan lalapan.",
        imageUrl: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/730/header.jpg",
      ),
      ProdukModel(
        id: 3,
        namaProduk: "Es Teh Manis Jumbo",
        harga: 5000,
        description: "Es teh manis segar pelepas dahaga ukuran jumbo.",
        imageUrl: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/730/header.jpg",
      ),
      ProdukModel(
        id: 4,
        namaProduk: "Mie Goreng Seafood",
        harga: 28000,
        description: "Mie goreng dengan udang, cumi, bakso ikan dan sayuran segar.",
        imageUrl: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/730/header.jpg",
      ),
      ProdukModel(
        id: 5,
        namaProduk: "Sate Ayam Madura",
        harga: 28000,
        description: "10 tusuk sate ayam daging pilihan dengan siraman bumbu kacang kental.",
        imageUrl: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/730/header.jpg",
      ),
    ]);

    isLoading.value = false;
  }

  // Kelola jumlah beli produk
  void tambahQty(int id) {
    pesanan[id] = (pesanan[id] ?? 0) + 1;
  }

  void kurangQty(int id) {
    final current = pesanan[id] ?? 0;
    if (current > 1) {
      pesanan[id] = current - 1;
    } else {
      pesanan.remove(id);
    }
  }

  int getQty(int id) => pesanan[id] ?? 0;

  // Rumus Matematika Kasir
  double get subtotal {
    double total = 0.0;
    for (var item in listMenu) {
      total += item.harga * getQty(item.id);
    }
    return total;
  }

  // Diskon 10% jika subtotal >= Rp 100.000
  double get nominalDiskon {
    if (subtotal >= 100000) {
      return subtotal * (diskonPersen.value / 100);
    }
    return 0.0;
  }

  double get setelahDiskon => subtotal - nominalDiskon;
  double get nominalPpn => setelahDiskon * (ppnPersen.value / 100);
  double get totalAkhir => setelahDiskon + nominalPpn;

  void hitungKembalian() {
    double bayar = double.tryParse(txtBayar.text.trim()) ?? 0.0;
    if (bayar < totalAkhir) {
      Get.snackbar(
        "Validasi",
        "Uang bayar masih kurang!",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      kembalian.value = 0.0;
      return;
    }
    kembalian.value = bayar - totalAkhir;
  }

  void resetPesanan() {
    pesanan.clear();
    txtBayar.clear();
    kembalian.value = 0.0;
  }

  @override
  void onClose() {
    txtBayar.dispose();
    super.onClose();
  }
}
