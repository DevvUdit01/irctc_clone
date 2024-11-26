import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:udit_assesment/features/signup/signup_page_controller.dart';

class SignupPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignupPageController());
  }

}