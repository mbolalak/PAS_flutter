import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/menu_drawer_controller.dart';
import '../components/menu_drawer.dart';
import '../menus/home.dart';
import '../menus/feat.dart';
import '../menus/profile.dart';

class MenuDrawerPage extends StatelessWidget {
  MenuDrawerPage({super.key});

  // 1. Inject controller sekali di halaman shell utama
  final MenuDrawerController drawerCtr = Get.put(MenuDrawerController());

  // 2. Daftar halaman konten yang akan ditampilkan di body
  final List<Widget> pages = [
    HomePage(),
    FeatPage(),
    const ProfilePage(),
  ];

  // 3. Judul AppBar yang otomatis berganti mengikuti halaman aktif
  final List<String> titles = [
    'Sistem Kasir & MTK',
    'Premier League Teams',
    'Profil Siswa',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // APPBAR DINAMIS
        appBar: AppBar(
          backgroundColor: const Color(0xFF171A21),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            titles[drawerCtr.selectedIndex.value],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),

        // DRAWER SAMPING
        drawer: const MenuDrawer(),

        // BODY DINAMIS (berganti sesuai menu drawer yang ditekan)
        body: pages[drawerCtr.selectedIndex.value],
      ),
    );
  }
}
