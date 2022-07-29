import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'package:quran_call/app/constants/color.dart';
import 'package:quran_call/app/routes/app_pages.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quran Call",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "By PPPA",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              width: 300,
              height: 300,
              child: Lottie.asset("assets/lottie/intro.json"),
            ),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              child: Text(
                "Get Started",
                style:
                    TextStyle(color: Get.isDarkMode ? appPurpleDark : appWhite),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Get.isDarkMode ? appWhite : appPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
