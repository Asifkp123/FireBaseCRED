import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'screens/ModelClass.dart';

class ProviderClass extends ChangeNotifier {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController AgeController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  List modellist = [];
  List updatListt = [];
  void AddData() {
    Map<String, Object> dataMap = HashMap();

    dataMap["Name"] = Namecontroller.text;
    dataMap["Age"] = AgeController.text;
    dataMap["PhoneNumber"] = PhoneController.text;

    db.collection("STUDENTS").doc().set(dataMap);

    // clearData();
  }

  void clearData() {
    Namecontroller.clear();
    PhoneController.clear();
    AgeController.clear();
  }

  // void getdata() {
  //   db.collection('STUDENTS').get().then((value) {
  //     print(value.docs.toString());
  //   });
  // }

  void clear() {
    modellist.clear();
  }

  void delete(String id) {
    // print(id + "helloooo");
    db.collection("STUDENTS").doc(id).delete();

    getdataa();
    notifyListeners();
  }

// void UpdataData(){
//   var snapshots = db
//         .collection('profile')
//         .doc()
//         .collection()
//         .get();

//         await snapshots.forEach((document) async {
//   document.reference.updateData(<String, dynamic>{
//     name: this.name
//   });

// }

  void getdataa() {
    modellist.clear();
    db.collection("STUDENTS").get().then((value) {
      for (var element in value.docs) {
        Map<dynamic, dynamic> map = element.data();
        modellist.add(
          UserModel(
            map["PhoneNumber"].toString(),
            map["Age"].toString(),
            map["Name"].toString(),
            element.id,
          ),
        );
      }
      notifyListeners();
    });
  }

  void update_data(id, age, name, phoneNumber) {
    // modellist.clear();
    db.collection("STUDENTS").get().then((value) {
      Map<String, Object> dataMap1 = HashMap();

      PhoneController.text = phoneNumber.toString();
      AgeController.text = age.toString();
      Namecontroller.text = name.toString();
      db.collection("STUDENTS").doc(id).update(dataMap1);
      print(id + "function ioddd");
    });

    print(Namecontroller.text);
  }
}
