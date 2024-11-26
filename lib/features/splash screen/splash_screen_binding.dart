import 'package:get/get.dart';
import 'package:udit_assesment/features/splash%20screen/splash_screen_controller.dart';
class SplashScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}