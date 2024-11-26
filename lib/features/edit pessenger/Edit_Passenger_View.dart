import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/edit%20pessenger/Edit_Passenger_controller.dart';

class EditPassengerView extends GetView<EditPassengerController> {
  const EditPassengerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Passenger Details',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                customTextField('Name', 'Enter Your Name', controller.passengerData?['name'] ?? '', enabled: false),
                customTextField('Age', 'Enter Age', controller.ageController.text, enabled: true, validator: controller.validateAge),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
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
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Berth Preference',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.passengerData?['berth preference'] ?? '',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                customTextField('Address Details', 'Enter Address', controller.addressController.text, enabled: true, validator: controller.validateAddress),
                customTextField('Mobile Number', 'Enter Mobile Number', controller.mobileController.text, enabled: true, validator: controller.validateMobile),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.checkValidation();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(400, 50),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      }),
    );
  }

  Padding customTextField(String labelText, String hintText, String textValue, {bool enabled = true, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xFF5A5959)),
          ),
          TextFormField(
            controller: enabled ? TextEditingController(text: textValue) : null,
            enabled: enabled,
            readOnly: !enabled,
            decoration: InputDecoration(
              labelText: enabled ? hintText : textValue,
              fillColor: Colors.grey.shade100,
              filled: true,
            ),
            keyboardType: TextInputType.name,
            validator: enabled ? validator : null,
          ),
        ],
      ),
    );
  }
}
