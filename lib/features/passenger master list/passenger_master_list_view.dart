import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/edit%20pessenger/Edit_Passenger_controller.dart';
import 'package:udit_assesment/features/passenger%20master%20list/passenger_master_list_controller.dart';
import 'package:udit_assesment/routing/routes_constant.dart';

class PassengerMasterListView extends GetView<PassengerMasterListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Master List'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('passengers').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No data found'));
                    }

                    final doc = snapshot.data!.docs;
                    print('length is ${doc.length}');
                    return ListView.builder(
                      itemCount: doc.length,
                      itemBuilder: (context, index) {
                        var data = doc[index];
                        return Card(
                          elevation: 10,
                          child: ListTile(
                            title: Text("Name: ${data['name']}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gender: ${data['gender']}"),
                                Text("Preference: ${data['berth prefrence']}"),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 130, // Adjust this value as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // EditPassengerController.setDocId(data.id);
                                      Get.toNamed(RoutesConstant.editPessenger,
                                      arguments: data.id
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.deletePassengerData(data.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(RoutesConstant.addPessenger);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(Get.width * 0.8, Get.height * 0.06),
                ),
                child: const Text(
                  'Add Passenger',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
