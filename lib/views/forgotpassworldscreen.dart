import 'package:fireconnct/views/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        // ignore: prefer_const_constructors
        title :Text("Forgot Password"),
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
                  decoration :InputDecoration(hintText: 'Email' , enabledBorder: OutlineInputBorder()  , prefixIcon: Icon(Icons.email)),
                ),),
                SizedBox(
                  height: 20,
                ),
               
                
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: (){}, child: Text("Forgot Password")),
                 SizedBox(
                  height: 20,
                ),
               
                 SizedBox(
                  height: 20,
                ),
                
            ],
          ),
        ),
      )
    );
  }
}