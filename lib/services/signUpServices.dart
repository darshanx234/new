// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireconnct/views/loginscreen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

signUpUser(
  String userName,
  String userEmail,
  String userPassword,
) async {
  User? userid = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName': userName,
      'userEmail': userEmail,
      'CreatedAt': DateTime.now(),
      'userId': userid!.uid,
    }).then((value) =>
        {FirebaseAuth.instance.signOut(), Get.to(() => HomeScreen())});
    print("data is stored");
  } on FirebaseAuthException catch (e) {
    // ignore: avoid_print
    print("Error $e");
  }
}
