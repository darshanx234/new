import 'package:fireconnct/addmember.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/group.dart';
import '../services/hive_database_service.dart';

class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final _formKey = GlobalKey<FormState>();
  String groupName = '';
  HiveDatabaseService hiveService = HiveDatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Group'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Group Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a group name';
                }
                return null;
              },
              onSaved: (value) {
                groupName = value!;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Create a new group
                  Group newGroup =
                      Group(name: groupName, members: [], expenses: []);

                  // Add the group to the Hive database
                  await hiveService.addGroup(newGroup);

                  // Save the group name in SharedPreferences
                  await Hive.box('allgroups').add(groupName);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => membersadd(groupName: groupName),
                    ),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
