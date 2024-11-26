import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:udit_assesment/features/BottomNavigation/bottom_navigation_bar_controller.dart';
import 'package:udit_assesment/features/add%20pessenger/Add_Passenger_View.dart';
import 'package:udit_assesment/features/homepage/home_page_view.dart';
import 'package:udit_assesment/features/search%20train/Search_Train_View.dart';


class BottomNavigationBarView extends GetView<BottomNavigationBarController>{
  const BottomNavigationBarView({super.key});

  
  

  @override
  Widget build(BuildContext context) {
  
  List<Widget> IndexPage (){
    return  [
    HomePageView(),
    SearchTrainView(),
    AddPassengerView(),
    HomePageView()
  ];
  }

   return  Scaffold(
    bottomNavigationBar: PersistentTabView(context,
     backgroundColor: Colors.black,
     
     screens: IndexPage(),
      controller: controller.controller,
        items: [
              PersistentBottomNavBarItem(
              icon: Icon(Icons.home,
              color: Colors.white,
              ),
              title: 'Home',
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
              ),
              PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.globe),
              title: 'Search'
              ),
              PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.person_circle_fill),
              title: 'User'
              ),
              PersistentBottomNavBarItem(
              icon: Icon(Icons.more_horiz),
              title: 'more'
              ),

          ],
           
          navBarStyle: NavBarStyle.style7,
    ),
);
}
}