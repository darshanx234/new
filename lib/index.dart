// ignore_for_file: prefer_const_constructors

import 'package:fireconnct/addmember.dart';
import 'package:fireconnct/views/Homepage.dart';
import 'package:fireconnct/views/addgroup.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Let\'s go!', style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              height: 15,
            ),
            Text('Create a new group and start your expense', style: TextStyle(color: Colors.white24)),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddGroup()));
              },
              child: Text('New Group', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              ),
            )
          ],
        ),
      ),
    );
  }
}