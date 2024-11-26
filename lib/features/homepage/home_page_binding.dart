import 'package:get/get.dart';
import 'package:udit_assesment/features/homepage/home_page_controller.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }

}