import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassengerMasterListController extends GetxController{
    RxBool isSearchClick = false.obs;
  RxString searchText = ''.obs;
  var searchController = TextEditingController();
  var nameController = TextEditingController();
  var contentController = TextEditingController();
  File? file;
  
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> updateStatus(String documentId) async {
   try{
     await firebaseFirestore
        .collection('passengers')
        .doc(documentId)
        .update({'name': nameController.text, 'content': contentController.text});
    Get.snackbar('Update Data', 'Data Update Successfully...',
        backgroundColor: const Color(0xFF0DEC14));
    nameController.clear();
    contentController.clear();
   } on FirebaseException catch(e){
      Get.snackbar('Error', e.code,
            backgroundColor: Colors.red);
   }
    catch (e) {
      
        Get.snackbar('An Error Occured', e.toString(),
            backgroundColor: Colors.red);
      }

  }

  Future<void> deletePassengerData(String documentId) async {
    await firebaseFirestore
        .collection('passengers')
        .doc(documentId)
        .delete();
    Get.snackbar('Data Delete', 'Data Delete Successfully...',
        backgroundColor: Colors.red);
  }  
}