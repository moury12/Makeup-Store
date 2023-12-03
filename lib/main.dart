import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfecto/pages/home/home_page.dart';
import 'package:perfecto/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfecto',
      theme: ThemeData.light(),
      getPages: AppRoutes.routes(),
      initialRoute: HomeScreen.routeName,
    );
  }
}


