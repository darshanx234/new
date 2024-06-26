import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireconnct/addmember.dart';
import 'package:fireconnct/index.dart';
import 'package:fireconnct/models/expense.dart';
import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/models/member.dart';
import 'package:fireconnct/services/hive_database_service.dart';
import 'package:fireconnct/theam/theamcontroller.dart';
import 'package:fireconnct/views/Homepage.dart';
import 'package:fireconnct/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  final themeController = Get.put(ThemeController());

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
  }

  @override
  Widget build(BuildContext context) {
    var groupBox = Hive.box('allgroups');
    // print(groupBox.length);
    // print(groupBox.values.toList()[0]);
    return Obx(() {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Get.find<ThemeController>().isDarkTheme.value
              ? ThemeData.dark().copyWith(
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.white),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    backgroundColor: Color.fromARGB(
                        218, 0, 0, 0), // Set the color of the AppBar
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor:
                        Colors.black54, // Set the color of the navigation bar
                  ),
                )
              : ThemeData.light().copyWith(
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.white),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    backgroundColor: const Color.fromARGB(
                        218, 0, 0, 0), // Set the color of the AppBar
                  ),
                  tabBarTheme: TabBarTheme(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(30), // Set the border radius
                      color: Colors.black,
                    ),
                  ),
                  // Set the color of the navigation bar
                ),
          home: (groupBox.isEmpty == false)
              ? HomePage(
                  groupName: groupBox.values.toList().first,
                )
              : Start());
    });
  }
}
