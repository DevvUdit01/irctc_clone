

import 'package:get/get.dart';
import 'package:udit_assesment/features/add%20pessenger/Add_Passenger_controller.dart';


class AddPassengerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddPassengerController());
    // TODO: implement dependencies
  }

}