import 'package:get/get.dart';
import 'package:udit_assesment/features/search%20train/Search_Train_controller.dart';

class SearchTrainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchTrainController());
  }

}