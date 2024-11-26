import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udit_assesment/routing/routes_constant.dart';

class EditPassengerController extends GetxController {
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  RxInt gender = 0.obs;
  RxString selectedPreference = ''.obs;
  List<String> preferencesList = [
    'Lower',
    'Middle',
    'Upper',
    'No Preferences',
    'Side Lower',
    'Upper Lower',
  ];
  late String docId;
  RxBool isLoading = true.obs;
  Map<String, dynamic>? passengerData;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is String) {
      docId = args;
      fetchPassengerData();
    }
  }

  void fetchPassengerData() async {
    try {
      isLoading.value = true;
      DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance.collection('passengers').doc(docId).get();

      if (doc.exists) {
        passengerData = doc.data();
        if (passengerData != null) {
          ageController.text = passengerData!['age'].toString();
          addressController.text = passengerData!['address'];
          mobileController.text = passengerData!['mobile'];
          gender.value = passengerData!['gender'] == 'Male'
              ? 1
              :2;
          selectedPreference.value = passengerData!['berth preference'];
        }
      }
    } catch (e) {
      print('Error fetching passenger data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Select gender method
  int selectGender(int selectvalue) {
    if (selectvalue == 1 || selectvalue == 2 || selectvalue == 3) {
      gender.value = selectvalue;
    }
    return gender.value;
  }

  // Validation methods
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

  void checkValidation() {
    if (formKey.currentState!.validate()) {
      save();
    } else {
      print('Form not filled');
    }
  }

  void save() async {
    try {
      await FirebaseFirestore.instance.collection('passengers').doc(docId).update({
        'age': int.parse(ageController.text),
        'address': addressController.text,
        'mobile': mobileController.text,
        'gender': gender.value == 1 ? 'Male' : gender.value == 2 ? 'Female' : 'Other',
        // 'name': passengerData!['name'], 
        // 'berth preference': passengerData!['berth preference'],
      });

      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Success',
        content: Column(
          children: [
            Image.asset('assets/successful.png', height: 100),
            Text(
              'Thank you, your information has been edited',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
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
            child: Text(
              'Ok',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          )
        ],
      );
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
