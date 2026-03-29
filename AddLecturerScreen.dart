import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../data/LecturerModel.dart';

class DatabaseHelper {
  // Method to update existing lecturer data in Firebase Realtime Database.
  static Future<void> updateLecturerData(
      String key, LecturerData lecturerData, BuildContext context) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child("Lectur").child(key).update(lecturerData.toJson())
        .then((value) => print("The ${lecturerData.name} lecturer is updated successfully!"))
        .catchError((error) {
      print("Failed to update lecturer data: $error");
      throw error;
    });
  }

  // Method to read lecturer data from Firebase Realtime Database and return it via a callback function.
  static void readFirebaseRealtimeDBMain(
      Function(List<Lecturer>) lecturerListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("Lectur").onValue.listen((lecturerDataJson) {
      if (lecturerDataJson.snapshot.exists) {
        List<Lecturer> lecturerList = [];
        lecturerDataJson.snapshot.children.forEach((element) {
          LecturerData lecturerData = LecturerData.fromJson(element.value as Map);
          Lecturer lecturer = Lecturer(element.key, lecturerData);
          lecturerList.add(lecturer);
        });
        lecturerListCallback(lecturerList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }

  // Method to add a new lecturer to the Firebase Realtime Database.
  static Future<void> addLecturer(Lecturer lecturer) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child("Lectur");
    Map<String, dynamic> lecturerData = lecturer.lecturerData?.toJson() ?? {};
    lecturerData['imageName'] = lecturer.lecturerData?.imagePath;
    await databaseReference.push().set(lecturerData)
        .then((value) => print("Lecturer added successfully!"))
        .catchError((error) {
      print("Failed to add lecturer: $error");
      throw error;
    });
  }

  // Method to delete a lecturer from the Firebase Realtime Database.
  static Future<void> deleteLecturer(String key) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child("Lectur").child(key).remove()
        .then((value) => print("Lecturer deleted successfully!"))
        .catchError((error) {
      print("Failed to delete lecturer: $error");
      throw error;
    });
  }

  // Method to add a new admin to the Firebase Realtime Database.
}
