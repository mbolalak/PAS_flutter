import 'package:get/get.dart';
import 'package:pas_flutter/menus/home.dart';
import 'pages/login_page.dart';
 import 'pages/menu_drawer_page.dart';

class Routes {
  static const String login = "/login";
  static const String kasir = "/kasir";
  static const String menuDrawer = "/menuDrawer"; // 1. Tambahkan nama rute di sini

  static final myPages = [
    GetPage(name: login, page: () => LoginPage()),
     GetPage(name: kasir, page: () => HomePage()),
     GetPage(name: menuDrawer, page: () => MenuDrawerPage()), // 2. Daftarkan di sini
  ];
}