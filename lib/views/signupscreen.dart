// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireconnct/services/signUpServices.dart';
import 'package:fireconnct/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SignUpScreen> {
  TextEditingController userNameContoroller = TextEditingController();
  TextEditingController userEmailContoroller = TextEditingController();
  TextEditingController userPasswordContoroller = TextEditingController();
  TextEditingController usercPasswordContoroller = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text("SignUp Screen"),
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
                    controller: userNameContoroller,
                    decoration: InputDecoration(
                        hintText: 'Enter Username',
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: userEmailContoroller,
                    decoration: InputDecoration(
                        hintText: 'Enter Email',
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
                    controller: userPasswordContoroller,
                    decoration: InputDecoration(
                        hintText: 'Enter Password',
                        labelText: "Password",
                        suffixIcon: Icon(Icons.password),
                        prefixIcon: Icon(Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'ReEnter Password ',
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: Icon(Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var userName = userNameContoroller.text.trim();
                      var userEmail = userEmailContoroller.text.trim();
                      var userPassword = userPasswordContoroller.text.trim();
                      var usercPassword = usercPasswordContoroller.text.trim();

                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: userEmail, password: userPassword)
                          .then((value) => {
                                print("user Created"),
                                signUpUser(userName, userEmail, userPassword),
                                print(value)
                              });
                    },
                    child: Text("SignUp")),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    navigator?.pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen(),
                    ));
                  },
                  child: Container(
                      child: Card(
                          child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Already Have an Accoutn Login"),
                  ))),
                ),
              ],
            ),
          ),
        ));
  }
}
