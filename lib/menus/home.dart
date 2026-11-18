import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/kasir_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(KasirController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // DAFTAR MENU
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.listMenu.length,
                itemBuilder: (context, index) {
                  final item = controller.listMenu[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      // Gambar Produk
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.fastfood, color: Colors.grey),
                          ),
                        ),
                      ),
                      title: Text(
                        item.namaProduk,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        "Rp ${item.harga.toStringAsFixed(0)}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                            onPressed: () => controller.kurangQty(item.id),
                          ),
                          Text(
                            "${controller.getQty(item.id)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle, color: Colors.green),
                            onPressed: () => controller.tambahQty(item.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // PANEL PERHITUNGAN MATEMATIKA KASIR (FOOTER)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Rincian Pembayaran",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      if (controller.pesanan.isNotEmpty)
                        GestureDetector(
                          onTap: () => controller.resetPesanan(),
                          child: const Text(
                            "Reset",
                            style: TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _infoRow("Subtotal", "Rp ${controller.subtotal.toStringAsFixed(0)}"),
                  _infoRow(
                    "Diskon (${controller.diskonPersen.value.toStringAsFixed(0)}%)",
                    "- Rp ${controller.nominalDiskon.toStringAsFixed(0)}",
                    color: Colors.red[700],
                  ),
                  _infoRow(
                    "PPN (${controller.ppnPersen.value.toStringAsFixed(0)}%)",
                    "+ Rp ${controller.nominalPpn.toStringAsFixed(0)}",
                  ),
                  const Divider(thickness: 1),
                  _infoRow(
                    "Total Tagihan",
                    "Rp ${controller.totalAkhir.toStringAsFixed(0)}",
                    isBold: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.txtBayar,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Uang Bayar (Rp)",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => controller.hitungKembalian(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF171A21),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: const Text("Hitung"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    "Kembalian",
                    "Rp ${controller.kembalian.value.toStringAsFixed(0)}",
                    isBold: true,
                    color: Colors.green[800],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 15 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 15 : 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
