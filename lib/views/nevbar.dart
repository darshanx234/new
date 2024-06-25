// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireconnct/index.dart';
import 'package:fireconnct/services/hive_database_service.dart';
import 'package:fireconnct/theam/theamcontroller.dart';
import 'package:fireconnct/views/Homepage.dart';
import 'package:fireconnct/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class Nevbar extends StatefulWidget {
  const Nevbar({Key? key}) : super(key: key);

  @override
  State<Nevbar> createState() => _NevbarState();
}

class _NevbarState extends State<Nevbar> {
  HiveDatabaseService hiveService = HiveDatabaseService();
  late Box group;

  @override
  void initState() {
    super.initState();
    group = Hive.box('allgroups');
  }

  @override
  Widget build(BuildContext context) {
    print(group.length);

    return Stack(
      children: [
        Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                width: double.maxFinite,
                color: Get.isDarkMode ? Colors.black : Colors.black87,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Groups',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                // Handle edit button press
                              },
                            ),
                          ],
                        ),
                      ),
                      ...group.keys.map((key) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  print('Yes tapped');
                                  await hiveService.deleteGroup(group.get(key));
                                  setState(() {
                                    group.delete(key);
                                  });
                                  if (group.length > 0) {
                                    navigator?.pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage(
                                                  groupName:
                                                      group.values.toList()[0],
                                                )));
                                  } else {
                                    navigator?.pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Start()));
                                  }
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Icon(Icons.group),
                            title: Text(group.get(key),
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              // Handle group tap
                              navigator?.pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(
                                        groupName: group.get(key),
                                      )));
                            },
                          ),
                        );
                      }).toList()
                    ],
                  ),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text("My Profile"),
                  onTap: () {
                    print('fav');
                  }),
              ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text("Change Theme"),
                  onTap: () {
                    Get.find<ThemeController>().changeTheme();
                  }),
              ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("Favorite"),
                  onTap: () {
                    print('fav');
                  }),
              ListTile(
                leading: Icon(Icons.star_border_outlined),
                title: Text("Rate Us"),
              ),
              ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text("LogOut"),
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => HomeScreen());
                    } catch (e) {
                      print(e.toString());
                    }
                  }),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () {
              navigator?.pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Start()));
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
