
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SearchTrainController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  var selectedStation = ''.obs;
  String? classValue;
  String? quotaValue;
  RxBool fromValid = false.obs;

  var photo = Rx<File?>(null);
 final ImagePicker picker = ImagePicker();

  void showCalender() async {
    DateTime? userSelectDate = await showDatePicker(
      context: Get.overlayContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (userSelectDate != null) {
      dateController.text =
          "${userSelectDate.year}-${userSelectDate.month}-${userSelectDate.day}";
    } else {
      print('date not selected');
    }
  }

  void showFromList() {
    showModalBottomSheet(
      context: Get.overlayContext!,
      builder: (context) {
        return  Wrap(
        children: [
          const SizedBox(height: 10,),
          customList("Gwalior",fromController),
          customList("Bhopal",fromController),
          customList("Indore",fromController),
          customList("Banglore",fromController),
          customList("Bhind",fromController),
          ],
        );
      },
    );
  }

  ListTile customList(String cityname,TextEditingController myController) {
    return ListTile(
            focusColor: Colors.transparent,
            contentPadding:const EdgeInsets.all(15),
            title: Text(cityname,style:const TextStyle(fontSize: 25,fontWeight: FontWeight.w500,),),
            onTap: (){
              myController.text = cityname;
              Get.back();
            },
          );
  }

  void showToList() {
    showModalBottomSheet(
      context: Get.overlayContext!,
      builder: (context) {
        return Wrap(
          children: [
           const SizedBox(height: 10,),
          customList("Gwalior",toController),
          customList("Bhopal",toController),
          customList("Indore",toController),
          customList("Banglore",toController),
          customList("Bhind",toController),
          ],
        );
      },
    );
  }

  void checkValidation() {
    if(formKey.currentState!.validate()){
      fromValid.value = true;
     print('successfully filled form');
    SizedBox(
      height: 400,
      width: 400,
      child:Column(
          children: [
            Text("From: ${fromController.text}"),
        Text("To: ${toController.text}"),
        Text("Travel Date: ${dateController.text}"),
        Text("Class: $classValue"),
        Text("Quota: $quotaValue"),
          ],
      )
    );
    }
    else{
      print('please fill all the filled');
    }
  }


  Future imgFromGallery()async{
  final pickedfile = await picker.pickImage(source: ImageSource.gallery);
  if(pickedfile != null){
    photo.value = File(pickedfile.path);
    uploadFile();
  } else{
    Get.snackbar('error', 'no image selected');
  }
 }

 Future imgFromCamera()async{
  final pickedfile = await picker.pickImage(source: ImageSource.camera);
  if(pickedfile != null){
    photo.value = File(pickedfile.path);
    uploadFile();
  } else{
    Get.snackbar('error', 'no image selected');
  }
 }

 Future uploadFile()async{
  if(photo.value == null) return;
  final fileName = basename(photo.value!.path);
  final destination = 'files/$fileName';

  try{
    final ref = firebase_storage.FirebaseStorage.instance
    .ref(destination)
    .child("/file");
    await ref.putFile(photo.value!);
  } catch (e){
    Get.snackbar("Error", "An error while occurred while uploading th file");
  }
 }



 
}
