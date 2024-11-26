
import 'package:get/get.dart';
import 'package:udit_assesment/features/edit%20pessenger/Edit_Passenger_controller.dart';


class EditPassengerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditPassengerController());
  }

}