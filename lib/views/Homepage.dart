// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:fireconnct/data/database.dart';
// import 'package:hive/hive.dart';
import '../models/member.dart';
// import '../models/expense.dart';
import '../models/group.dart';
import '../services/hive_database_service.dart';
import 'package:fireconnct/views/add_expense.dart';
import 'package:fireconnct/views/data.dart';
import 'package:fireconnct/views/expense.dart';
import 'package:fireconnct/views/make_payment.dart';
import 'package:fireconnct/views/nevbar.dart';
import 'package:fireconnct/views/overview.dart';
import 'package:fireconnct/views/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_navigation/get_navigation.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:hive/hive.dart';

// import 'package:fireconnct/main.dart';

class HomePage extends StatefulWidget {
  var groupName;

  HomePage({required this.groupName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HiveDatabaseService hiveService = HiveDatabaseService();
  final _controller = TextEditingController();

  List<Map<String, dynamic>> name = [];
  List<String> doption = [];
  List<Map<String, dynamic>> showexpense = [];

  @override
  @override
  void initState() {
    super.initState();
    loadGroupData();
  }

  Future<void> loadGroupData() async {
    Group? group = await hiveService.getGroup(widget.groupName);
    if (group != null) {
      setState(() {
        name = group.members
            .map((member) => {'name': member.name, 'money': member.money})
            .toList();
        doption = group.members.map((member) => member.name).toList();
        showexpense = group.expenses
            .map((expense) => {
                  'title': expense.name,
                  'amount': expense.amount,
                  'paidBy': expense.paidBy,
                })
            .toList();
        print(showexpense);
      });
    }
  }

  void savenewtask() async {
    Group group = await hiveService.getGroup(widget.groupName);
    // Add the new member to the group
    Member newMember = Member(
      name: _controller.text,
      money: 0,
    );
    group.members.add(newMember);

    // Update the group in the Hive database
    await hiveService.updateGroup(widget.groupName, group);

    setState(() {
      name = group.members
          .map((member) => {'name': member.name, 'money': member.money})
          .toList();
      doption.add(_controller.text);
    });
    Navigator.of(context).pop();
    // Clear the text field
    _controller.clear();
  }

  // ... rest of your code ...

  void addNewPerson() {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return DialogBox(
            controller: _controller,
            onsave: savenewtask,
            oncancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void addNewExpense() {
    print("button clicked");
    navigator?.push(MaterialPageRoute(
        builder: (BuildContext context) => AddExpense(
              // options: allmembers

              onSave: expensesave,
              groupName: widget.groupName,
              members: doption,
            )));
  }

  void makexpayment() {
    // replace 'groupKey' with the actual key

    navigator?.push(MaterialPageRoute(
      builder: (BuildContext context) => MakePayment(
        // groupBox: groupBox,
        group: widget.groupName,
        paymentSave: paymentsave,
        people: doption,
      ),
    ));
  }

  void expensesave() {
    print(Userdata.expensea);
    setState(() {
      Future.microtask(() async {
        Group group = await hiveService.getGroup(widget.groupName);
        showexpense = group.expenses
            .map((expense) => {
                  'title': expense.name,
                  'amount': expense.amount,
                  'paidBy': expense.paidBy,
                })
            .toList();
        name = group.members
            .map((member) => {'name': member.name, 'money': member.money})
            .toList();
      });
    });
    Navigator.of(context).pop();
  }

  void paymentsave() {
    setState(() {
      Navigator.of(context).pop();
      Future.microtask(() async {
        Group group = await hiveService.getGroup(widget.groupName);
        name = group.members
            .map((member) => {'name': member.name, 'money': member.money})
            .toList();
      });
    });
  }

  void deleteExpense() async {
    Group group = await hiveService.getGroup(widget.groupName);

    // await groupService.deleteExpense('groupKey', 'expenseKey');
    setState(() {
      showexpense = group.expenses
          .map((expense) => {
                'title': expense.name,
                'amount': expense.amount,
                'paidBy': expense.paidBy,
              })
          .toList();
      name = group.members
          .map((member) => {'name': member.name, 'money': member.money})
          .toList();
    });
  }

  void updateState() {
    setState(() {
      Future.microtask(() async {
        Group group = await hiveService.getGroup(widget.groupName);
        showexpense = group.expenses
            .map((expense) => {
                  'title': expense.name,
                  'amount': expense.amount,
                  'paidBy': expense.paidBy,
                })
            .toList();
        name = group.members
            .map((member) => {'name': member.name, 'money': member.money})
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Nevbar(),
        appBar: AppBar(
          title: Text("GROUP EXPENSE MANAGER"),
          elevation: 0,
          // backgroundColor: Colors.orange,
          bottom: TabBar(tabs: [
            Tab(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Expenses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
        ),
        floatingActionButton: SpeedDial(
          // backgroundColor: Colors.orange,
          animatedIcon: AnimatedIcons.menu_close,
          // overlayColor: Colors.white,
          overlayOpacity: 0.8,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.group_add,
                // color: Colors.orange,
              ),
              label: "New person",
              onTap: addNewPerson,
            ),
            SpeedDialChild(
                child: Icon(
                  Icons.arrow_back,
                  // color: Colors.orange,
                ),
                label: "New Payment",
                onTap: makexpayment),
            SpeedDialChild(
                child: Icon(
                  Icons.money_off_csred_outlined,
                  // color: Colors.orange,
                ),
                label: "New expense",
                onTap: addNewExpense)
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(children: [
                Overview(
                  overall: name,
                  groupName: widget.groupName,
                  updateState: updateState,
                ),
                All_expense(
                  expense: showexpense,
                  groupName: widget.groupName,
                  delete: deleteExpense,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
