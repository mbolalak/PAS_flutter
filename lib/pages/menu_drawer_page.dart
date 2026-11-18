import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/menu_drawer_controller.dart';
import '../components/menu_drawer.dart';
import '../menus/home.dart';
import '../menus/feat.dart';
import '../menus/profile.dart';

class MenuDrawerPage extends StatelessWidget {
  MenuDrawerPage({super.key});

  final MenuDrawerController drawerCtr = Get.put(MenuDrawerController());

  final List<Widget> pages = [
    HomePage(),
    featpage(),
    const ProfilePage(),
  ];

  final List<String> titles = [
    'Sistem Kasir & MTK',
    'Daftar Tim',
    'Profil Siswa',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
        drawer: const MenuDrawer(),
        body: pages[drawerCtr.selectedIndex.value],
      ),
    );
  }
}
