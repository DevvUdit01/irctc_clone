
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/homepage/home_page_controller.dart';
import 'package:udit_assesment/routing/routes_constant.dart';


class HomePageView extends GetView<HomePageController>
{


  Widget Card2(String name,String title)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left:8.0,),
      child: Card(
        color: Colors.black.withOpacity(0.5),
        margin: EdgeInsets.all(4),
        elevation: 6 ,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:60 ,
            width: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(name,style: TextStyle(color: Colors.white,fontSize: 18),),
                Text(title,style: TextStyle(color: Colors.grey[300],fontSize: 12),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Card1(String name,String title,String img){

    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left:8.0,),
      child: Card(
        color: Colors.black12.withOpacity(0.001),
        margin: EdgeInsets.all(4),
        elevation: 6 ,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:120 ,
            width: 130,
                     child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color: Colors.blue,),
                  
                  child: Image.asset(img, height: 50,width: 50,color: Colors.white,)),
                  //Image(image: AssetImage(img),height: 50,width:50,color: Colors.white,)),
                Text(name,style: TextStyle(color: Colors.white,fontSize: 18),),
                Text(title,style: TextStyle(color: Colors.grey[300],fontSize: 12),)
              ],
            ),
          ),
        ),
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(




      body:  Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/img/home_bg.png"),
      fit: BoxFit.cover,
    ),)
          ),
          Padding(
            padding: const EdgeInsets.only(top:0,left:0,right:0),
            child: Container(
              decoration: BoxDecoration(color: Colors.green[400]?.withOpacity(0.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height:25),
                  Text("Train Services",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      InkWell(child: Card1("Train","Search your next Train","assets/img/train.png"),
                      onTap:(){
                      Get.toNamed(RoutesConstant.searchtrain);
                      } ,),
                      InkWell(child: Card1("Food","Food Delivery at your Seat","assets/img/food.png"),
                        onTap:(){} ,)
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(child: Card1("Book Seat","Passenger Reservation","assets/img/ask_disha.png"),
                        onTap:(){
                          Get.toNamed(RoutesConstant.passengerMasterList);  
                        } ,),
                      InkWell(child: Card1("Rooms","Book Rooms at Station","assets/img/rooms.png"),
                        onTap:(){
                        
                        } ,)
                    ],
                  ),

                   Text("Other Services",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),

                  Row(
                    children: [
                      InkWell(child: Card2("Flight","Book your next flight"),onTap: (){},),
                      InkWell(child: Card2("Hotel","Book your next stay"),onTap: (){},),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(child: Card2("Bus","Book your next bus"),onTap: (){},),
                      InkWell(child: Card2("Tourism","Explore tour options"),onTap: (){},),
                    ],
                  ),

                ],
              ),
            ),
                    ),
          ),]
      ),);
  }

}