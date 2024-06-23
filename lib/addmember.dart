// ignore_for_file: prefer_const_constructors

import 'package:fireconnct/views/Homepage.dart';
import 'package:fireconnct/views/data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/member.dart';
import '../models/group.dart';
import '../services/hive_database_service.dart';

class membersadd extends StatefulWidget {
  final String groupName;

  membersadd({required this.groupName});

  @override
  State<membersadd> createState() => _membersaddState();
}

class _membersaddState extends State<membersadd> {
  final _formKey = GlobalKey<FormState>();
  String memberName = '';
  HiveDatabaseService hiveService = HiveDatabaseService();
  List<Member> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              // Retrieve the group from the Hive database
              Group group = await hiveService.getGroup(widget.groupName);

              // Update the group's members
              group.members = members;

              // Update the group in the Hive database
              await hiveService.updateGroup(widget.groupName, group);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    groupName: widget.groupName,
                  ),
                ),
              );
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Enter Person name",
                    labelText: "New Person",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a person name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    memberName = value!;
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Create a new member
                  Member newMember = Member(name: memberName, money: 0.0);

                  // Add the member to the members list
                  setState(() {
                    members.add(newMember);
                  });
                  Group group = await hiveService.getGroup(widget.groupName);

                  // Update the group's members
                  group.members = members;

                  // Update the group in the Hive database
                  await hiveService.updateGroup(widget.groupName, group);
                  _formKey.currentState!.reset();
                }
              },
              child: Text('ADD'),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 1.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 10, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${members[index].name}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                '\$0.00',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                        thickness: 1.0,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
