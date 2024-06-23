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
import 'package:lottie/lottie.dart';


class HomeScreen extends StatefulWidget {
HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        // ignore: prefer_const_constructors
        title :Text("Login Screen"),
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
                margin: EdgeInsets.symmetric(horizontal:30.0),
                child: TextFormField(
                  
                  controller: loginEmailController ,
                  decoration :InputDecoration(hintText: ' Enter Email' , labelText: "Email"  , prefixIcon: Icon(Icons.email)),
                ),),
                SizedBox(
                  height: 20,
                ),
                Container(
                margin: EdgeInsets.symmetric(horizontal:30.0),
                child: TextFormField(
                  obscureText: true,
                  controller: loginpasswordController,
                  decoration :InputDecoration(hintText: ' Enter Password'  , labelText: "password" , suffixIcon: Icon(Icons.password) , prefixIcon: Icon(Icons.visibility)),
                ),),
                
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: () async{
                  var loginEmail = loginEmailController.text.trim();
                  var loginPassword = loginpasswordController.text.trim();
                  try{
                    final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmail, password: loginPassword)).user;
                    if(firebaseUser != null){
                     navigator?.pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  Start()));
                    }
                    else{
                      print("Check email and password");
                    }

                  }on FirebaseAuthException catch(e){
                    print("Error $e");
                  }


                }, child: Text("login")),
                 SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ForgotPasswordScreen());
                  },
                  child: Container(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(child: Text("Forgot Password")),
                  )),
                ),
                 SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap :() {
                    Get.to(() =>SignUpScreen());
                  },
                  child: Container(child: Card
                  (child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Don't have an Accout SignUp"),
                  ))),
                ),
            ],
          ),
        ),
      )
    );
  }
}