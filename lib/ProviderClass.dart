import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wiceprojet/screens/ThirdPage.dart';

import 'screens/ModelClass.dart';

class ProviderClass extends ChangeNotifier {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  // TextEditingController SearchController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  List modellist = [];

  List found = [];
  void AddData(String from, String id, String phone, BuildContext context,
      String? name1) {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, Object> dataMap = HashMap();

    dataMap["Name"] = Namecontroller.text;
    dataMap["Age"] = AgeController.text;
    dataMap["PhoneNumber"] = PhoneController.text;

    if (from == "edit") {
      db
          .collection("STUDENTS")
          .where('PhoneNumber', isEqualTo: phone)
          // .where('Name', isEqualTo: name1)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          db.collection("STUDENTS").doc(id).update(dataMap);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThirdPage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Phone Number Already exist")));
        }
      });
    } else {
      db
          .collection("STUDENTS")
          .where('PhoneNumber', isEqualTo: phone)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          db.collection("STUDENTS").doc(time).set(dataMap);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThirdPage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Phone Number Already exist")));
        }
      });
    }

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
        found = modellist;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  void update_data(String age, String name, String phoneNumber) {
    modellist.clear();
    PhoneController.text = phoneNumber.toString();
    AgeController.text = age.toString();
    Namecontroller.text = name.toString();
    notifyListeners();

    // db.collection("STUDENTS").get().then((value) {
    //   Map<String, Object> dataMap1 = HashMap();
    //   dataMap1["Age"] = age.toString();
    //   dataMap1["Name"] = name.toString();
    //   dataMap1["PhoneNumber"] = phoneNumber.toString();

    //   db.collection("STUDENTS").doc(id).update(dataMap1);
    //   print(id + "function ioddd");
    // });
  }

  void search_data(String query) {
    found = modellist.where((user) => user.name!.contains(query)).toList();
    notifyListeners();
  }
}
