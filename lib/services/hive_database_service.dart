import 'package:hive/hive.dart';
import '../models/member.dart';
import '../models/expense.dart';
import '../models/group.dart';

class HiveDatabaseService {
  // Function to open a box for a specific group
  Future<Box> openGroupBox(String groupName) async {
    return await Hive.openBox(groupName);
  }

  // Function to add a new group 
  Future<void> addGroup(Group group) async {
    var groupBox = await openGroupBox(group.name);
    // Add the group to the box
    await groupBox.put('group', group);

    // Add the group name to the list of group names
    var groupNameBox = await Hive.openBox('groupNames');
    groupNameBox.add(group.name);
  }

  // Function to retrieve a group
  Future<Group> getGroup(String groupName) async {
    var groupBox = await openGroupBox(groupName);
    // Retrieve the group from the box
    return groupBox.get('group');
  }

  // Function to update a group
  Future<void> updateGroup(String groupName, Group updatedGroup) async {
    var groupBox = await openGroupBox(groupName);
    // Update the group in the box
    await groupBox.put('group', updatedGroup);
  }

  // Function to delete a group
  Future<void> deleteGroup(String groupName) async {
    var groupBox = await openGroupBox(groupName);
    // Delete the group from the box
    await groupBox.delete('group');

    // Remove the group name from the list of group names
    var groupNameBox = await Hive.openBox('groupNames');
    int index = groupNameBox.values.toList().indexOf(groupName);
    if (index != -1) {
      groupNameBox.deleteAt(index);
    }
  }

  // Function to retrieve all groups
  Future<List<Group>> getAllGroups() async {
    List<Group> allGroups = [];

    // Get all group names
    var groupNameBox = await Hive.openBox('groupNames');
    List<dynamic> allGroupNames = groupNameBox.values.toList();

    // Retrieve all groups from their boxes
    for (String groupName in allGroupNames) {
      var groupBox = await openGroupBox(groupName);
      Group group = groupBox.get('group');
      if (group != null) {
        allGroups.add(group);
      }
    }

    return allGroups;
  }
}