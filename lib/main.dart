import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_call/app/constants/color.dart';
import 'dart:io';
import 'app/routes/app_pages.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new PostHttpOverrides();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      darkTheme: themeDark,
      title: "Application",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
