import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/menu_drawer_controller.dart';
import '../routes.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerCtr = Get.find<MenuDrawerController>();

    return Drawer(
      backgroundColor: const Color(0xFF171A21),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header Akun Profil
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF1B2838)),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color(0xFF66C0F4),
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            accountName: const Text(
              "Hanan Victor",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            accountEmail: const Text(
              "11 PPLG 3 - Absen 11",
              style: TextStyle(color: Colors.white70),
            ),
          ),

          // Menu 0: Home / Kasir
          Obx(() => ListTile(
                leading: const Icon(Icons.point_of_sale, color: Colors.white),
                title: const Text("Home Kasir", style: TextStyle(color: Colors.white)),
                selected: drawerCtr.selectedIndex.value == 0,
                selectedTileColor: const Color(0xFF2A475E),
                onTap: () {
                  drawerCtr.selectedIndex.value = 0;
                  Get.back();
                },
              )),

          // Menu 1: Daftar Tim (Feat API)
          Obx(() => ListTile(
                leading: const Icon(Icons.sports_soccer, color: Colors.white),
                title: const Text("Daftar Tim", style: TextStyle(color: Colors.white)),
                selected: drawerCtr.selectedIndex.value == 1,
                selectedTileColor: const Color(0xFF2A475E),
                onTap: () {
                  drawerCtr.selectedIndex.value = 1;
                  Get.back();
                },
              )),

          // Menu 2: Profile
          Obx(() => ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.white),
                title: const Text("Profile", style: TextStyle(color: Colors.white)),
                selected: drawerCtr.selectedIndex.value == 2,
                selectedTileColor: const Color(0xFF2A475E),
                onTap: () {
                  drawerCtr.selectedIndex.value = 2;
                  Get.back();
                },
              )),

          const Divider(color: Colors.white24),

          // Menu Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              Get.back();
              Get.offAllNamed(Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
