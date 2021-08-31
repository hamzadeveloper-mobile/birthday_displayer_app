import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataManagement {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileinfo');

  Future<void> createUserData(String name, String dob) async {
    try {
      String uid = FirebaseAuth.instance.currentUser.uid;
      return await profileList.doc(uid).set({
        'name': name,
        'dob': dob,
        'uid': uid,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateUserData(String name, String dob) async {
    try {
      String uid = FirebaseAuth.instance.currentUser.uid;

      return profileList.doc(uid).update({
        'name': name,
        'dob': dob,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }
}
