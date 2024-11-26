import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/splash%20screen/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (dynamic _) => Scaffold(
        body: SizedBox.expand(
          child: Image.asset(
            "assets/train4.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
