import 'package:get/get.dart';
import 'package:udit_assesment/features/otp%20authentication/otp_authentication_controller.dart';

class OtpAuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpAuthenticationController());
  }

}