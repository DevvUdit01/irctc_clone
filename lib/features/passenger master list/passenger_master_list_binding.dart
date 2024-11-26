import 'package:get/get.dart';
import 'package:udit_assesment/features/passenger%20master%20list/passenger_master_list_controller.dart';

class PassengerMasterListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PassengerMasterListController());
  }
  
}