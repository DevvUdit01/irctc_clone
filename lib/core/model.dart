import 'package:cloud_firestore/cloud_firestore.dart';

class SignupModel{
  String emailid;
  String name;
  String mobile;
  String password;

  SignupModel({
    required this.emailid,
    required this.name,
    required this.mobile,
    required this.password,
  });

 factory SignupModel.fromDocumentSnapshot(DocumentSnapshot doc){
    return SignupModel(
      emailid: doc['email id'],
      name: doc['name'],
      mobile: doc['mobile no'],
      password: doc['password'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'email id':emailid,
      'name':name,
      'mobile no':mobile,
      'password':password,
    };
  }
}

class AddPassengerModel{
  String name;
  int age ;
  String gender;
  String berthpref;
  String address;
  String mobile;

  AddPassengerModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.berthpref,
    required this.address,
    required this.mobile,
  });

 factory AddPassengerModel.fromDocumentSnapshot(DocumentSnapshot doc){
    return AddPassengerModel(
      name: doc['name'],
      age: doc['age'],
      gender: doc['gender'],
      berthpref: doc['berth prefrence'],
      address: doc['address'],
      mobile: doc['mobile no'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'age':age,
      'gender':gender,
      'berth prefrence':berthpref,
      'address' :address,
      'mobile no' :mobile,
    };
  }
}