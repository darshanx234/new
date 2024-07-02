import 'package:fireconnct/addmember.dart';
import 'package:fireconnct/views/Homepage.dart';
import 'package:fireconnct/views/addgroup.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';

class Start extends StatefulWidget {
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  late var groupBox;

  @override
  void initState() {
    super.initState();
    groupBox = Hive.box('allgroups');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (groupBox.isNotEmpty == true && groupBox.values.first != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage(
                      groupName: groupBox.values.first,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let\'s go!',
            ),
            SizedBox(
              height: 15,
            ),
            Text('Create a new group and start your expense',
                style: TextStyle(color: Color.fromARGB(255, 172, 166, 166))),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddGroup()));
              },
              child: Text(
                'New Group',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
