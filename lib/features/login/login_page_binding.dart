import 'package:get/get.dart';
import 'package:udit_assesment/features/login/login_page_controller.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController());
  }

}