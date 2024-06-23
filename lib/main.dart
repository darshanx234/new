// ignore_for_file: prefer_const_constructors

// import 'package:fireconnct/features/app/splash_screen/splash_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireconnct/addmember.dart';
import 'package:fireconnct/index.dart';
import 'package:fireconnct/models/expense.dart';
import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/models/member.dart';
import 'package:fireconnct/services/hive_database_service.dart';
// import 'package:fireconnct/test.dart';
import 'package:fireconnct/views/Homepage.dart';
// import 'package:fireconnct/views/add_expense.dart';
import 'package:fireconnct/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  Hive.registerAdapter(MemberAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(GroupAdapter());

  await Hive.openBox<Member>('members');
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox<Group>('groups');
  await Hive.openBox('allgroups');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  final hiveService = HiveDatabaseService();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    // print(user?.uid.toString());

    // Load initial data and check if boxes exist
    // loadInitialData();
    // checkIfBoxesExist();
  }

  // void loadInitialData() async {
  //   var groupBox = await Hive.openBox<Group>('groups');
  //   var memberBox = await Hive.openBox<Member>('members');
  //   var expenseBox = await Hive.openBox<Expense>('expenses');

  //   if (groupBox.isEmpty) {
  //     Group newGroup = Group(name: 'Vacation', members: [], expenses: []);
  //     hiveService.addGroup(newGroup);
  //   }
  // }

  // void checkIfBoxesExist() async {
  //   bool groupBoxExists = Hive.isBoxOpen('groups');
  //   bool memberBoxExists = Hive.isBoxOpen('members');
  //   bool expenseBoxExists = Hive.isBoxOpen('expenses');

  //   print('Group box exists: $groupBoxExists');
  //   print('Member box exists: $memberBoxExists');
  //   print('Expense box exists: $expenseBoxExists');
  // }

  @override
  Widget build(BuildContext context) {
    var groupBox = Hive.box('allgroups');
    return GetMaterialApp(
      home: groupBox.isNotEmpty
          ? HomePage(groupName: groupBox.getAt(0))
          : Start(),
    );
  }
}
