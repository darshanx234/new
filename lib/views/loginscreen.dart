// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireconnct/index.dart';
import 'package:fireconnct/views/Homepage.dart';
import 'package:fireconnct/views/forgotpassworldscreen.dart';
import 'package:fireconnct/views/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    var allgroups = Hive.box('allgroups');
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      if (allgroups.getAt(0) != null) {
        navigator?.pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(
                  groupName: allgroups.getAt(0),
                )));
      } else {
        navigator
            ?.pushReplacement(MaterialPageRoute(builder: (context) => Start()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var allgroups = Hive.box('allgroups');

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text("Login Screen"),
          actions: [Icon(Icons.more_vert)],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 300.0,
                  child: Lottie.asset("assets/login_animation.json"),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: loginEmailController,
                    decoration: InputDecoration(
                        hintText: ' Enter Email',
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    obscureText: !passwordVisible,
                    controller: loginpasswordController,
                    decoration: InputDecoration(
                        hintText: ' Enter Password',
                        labelText: "password",
                        suffixIcon: InkWell(
                          child: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        prefixIcon: Icon(Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var loginEmail = loginEmailController.text.trim();
                      var loginPassword = loginpasswordController.text.trim();
                      try {
                        final User? firebaseUser = (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: loginEmail, password: loginPassword))
                            .user;
                        if (firebaseUser != null) {
                          print(firebaseUser.uid);
                          if (allgroups.values.toList().first != null) {
                            print('Homescreen');
                            navigator!.push(MaterialPageRoute(
                                builder: (context) => HomePage(
                                      groupName:
                                          allgroups.values.toList().first,
                                    )));
                          } else {
                            print("start");
                            navigator!.pushReplacement(MaterialPageRoute(
                                builder: (context) => Start()));
                          }
                        } else {
                          final snackBar = SnackBar(
                            content: Text('Check email and password'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } on FirebaseAuthException catch (e) {
                        final snackBar = SnackBar(
                          content: Text('Invalid email and password'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("login")),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ForgotPasswordScreen());
                  },
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(child: Text("Forgot Password")),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    navigator?.pushReplacement(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: Container(
                      child: Card(
                          child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Don't have an Accout SignUp"),
                  ))),
                ),
              ],
            ),
          ),
        ));
  }
}
