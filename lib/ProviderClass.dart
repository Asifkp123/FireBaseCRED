import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController AgeController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  void AddData() {
    print(PhoneController.text.toString() + " rety");

    Map<String, Object> dataMap = HashMap();
    dataMap["Name"] = Namecontroller.text;
    dataMap["Age"] = PhoneController.text;
    dataMap["PhoneNumber"] = AgeController.text;

    db.collection("STUDENTS").doc(PhoneController.text.toString()).set(dataMap);
    // db.collection("STUDENTS").doc("8590022047").delete();

    // clearData();
  }

  void clearData() {
    Namecontroller.clear();
    PhoneController.clear();
    AgeController.clear();
  }

  void getdata() {
    db.collection("STUDENTS").get().then((value) {
      for (var element in value.docs) {
        Map<dynamic, dynamic> map = element.data() as Map;
        map["PHONE"].toString();
        map["IMAGE_URL"].toString();
        map["ADDRESS"].toString();
      }
      notifyListeners();
    });
  }
}
