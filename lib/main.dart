import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aplikasi PAS',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      getPages: Routes.myPages,
    );
  }
}