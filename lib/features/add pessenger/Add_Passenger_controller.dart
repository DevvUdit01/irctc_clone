import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udit_assesment/core/model.dart';
import 'package:udit_assesment/routing/routes_constant.dart';

class AddPassengerController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  RxInt gender = 0.obs;
  RxString selectedPreference = 'No Preferences'.obs;
  List<String> preferencesList = [
    'Lower',
    'Middle',
    'Upper',
    'No Preferences',
    'Side Lower',
    'Upper Lower',
  ];

  // Select gender method
  int selectGender(int selectvalue) {
    if (selectvalue == 1 || selectvalue == 2 || selectvalue == 3) {
      gender.value = selectvalue;
    }
    return gender.value;
  }

  // Select preference method
  void selectPreference(String preference) {
    selectedPreference.value = preference;
  }

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    final age = int.tryParse(value);
    if (age == null || age <= 0) {
      return 'Please enter a valid age';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  void checkValidation() async {
    if (formKey.currentState!.validate()) {
      AddPassengerModel passenger = AddPassengerModel(
        name: nameController.text,
        age: int.parse(ageController.text),
        gender: gender.value == 1 ? 'Male' : gender.value == 2 ? 'Female' : 'Other',
        berthpref: selectedPreference.value,
        address: addressController.text,
        mobile: mobileController.text,
      );

      try {
        await FirebaseFirestore.instance.collection('passengers').add(passenger.toMap());

        Get.defaultDialog(
          barrierDismissible: false,
          title: 'Success',
          content: Column(
            children: [
              Image.asset('assets/successful.png', height: 100,),
              Text('Thank you, your information has been saved', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutesConstant.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text('Ok', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),),
            )
          ],
        );
      } catch (e) {
        print('Error uploading data: $e');
      }
    } else {
      print('Form not filled');
    }
  }
}
