import 'package:get/get.dart';

class MenuDrawerController extends GetxController {
  // 0: Kasir, 1: Dummy, 2: Profil
  var selectedIndex = 0.obs;

  void gantiTab(int index) {
    selectedIndex.value = index;
  }
}