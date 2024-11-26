import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/add%20pessenger/Add_Passenger_controller.dart';

class AddPassengerView extends GetView<AddPassengerController> {
  const AddPassengerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Passenger Details',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField('Name', 'Enter Your Name', controller.nameController, controller.validateName),
                customTextField('Age', 'Enter Age', controller.ageController, controller.validateAge),
                // Add gender field
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 8),
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 3, bottom: 5),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Radio(
                              value: 1,
                              groupValue: controller.gender.value,
                              onChanged: (value) {
                                controller.selectGender(value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('Male'),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          Obx(
                            () => Radio(
                              value: 2,
                              groupValue: controller.gender.value,
                              onChanged: (value) {
                                controller.selectGender(value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('Female'),
                        ],
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
                // Add preferences
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 8),
                  child: Text(
                    'Berth Preferences',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 8),
                  child: Card(
                    child: DropdownButtonHideUnderline(
                      child: Obx(() => DropdownButton<String>(
                        value: controller.selectedPreference.value,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.selectPreference(newValue);
                          }
                        },
                        items: controller.preferencesList.map((String preference) {
                          return DropdownMenuItem<String>(
                            value: preference,
                            child: Text(preference),
                          );
                        }).toList(),
                      )),
                    ),
                  ),
                ),
                customTextField('Address Details', 'Enter Address', controller.addressController, controller.validateAddress),
                customTextField('Mobile Number', 'Enter Mobile Number', controller.mobileController, controller.validateMobile),
                const SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.checkValidation();
                    },
                    child: const Text(
                      'Book',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(400, 50),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding customTextField(String labelText, String hintText, TextEditingController textController, String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xFF5A5959)),
          ),
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
              labelText: hintText,
              fillColor: Colors.grey.shade100,
              filled: true,
            ),
            keyboardType: TextInputType.name,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
