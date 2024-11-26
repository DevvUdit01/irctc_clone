import 'package:get/get.dart';
import 'package:udit_assesment/features/BottomNavigation/bottom_navigation_bar_controller.dart';

class BottomNavigationBarBinding extends Bindings{
  @override
  void dependencies() {
    //Get.lazyPut(() => SettingsPageController());
    Get.lazyPut(() => BottomNavigationBarController());
  }

}