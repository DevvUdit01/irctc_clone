import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigationBarController extends GetxController{
   RxInt selectedIndex=0.obs;
  late PersistentTabController controller ;

@override
  void onInit() {
        controller = PersistentTabController();

    super.onInit();
  }
   
}