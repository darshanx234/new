import 'package:fireconnct/models/expense.dart';
import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/views/add_expense.dart';
import 'package:fireconnct/views/editExpense.dart';
import 'package:fireconnct/views/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/hive_database_service.dart';

class All_expense extends StatefulWidget {
  List expense;
  VoidCallback delete;
  String groupName;

  All_expense({
    super.key,
    required this.expense,
    required this.delete,
    required this.groupName,
  });

  @override
  State<All_expense> createState() => _OverviewState();
}

class _OverviewState extends State<All_expense> {
  HiveDatabaseService hiveService = HiveDatabaseService();

  final namectl = TextEditingController();
  final amountctl = TextEditingController();
  List<String> members = [];
  late Group group;

  @override
  void initState() {
    super.initState();
    loadGroupData();
  }

  Future<void> loadGroupData() async {
    Group? group = await hiveService.getGroup(widget.groupName);
    if (group != null) {
      setState(() {
        members = group.members.map((member) => member.name).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: widget.expense.map<Widget>((value) {
          return Align(
            alignment: Alignment.center,
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      group.deleteExpense(value['title'].toString());
                      await hiveService.updateGroup(widget.groupName, group);
                      widget.delete();
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.black87,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  SlidableAction(
                      onPressed: (context) {
                        showDialog(
                            context: context,
                            builder: (BuildContext contex) {
                              return Expenseedit(
                                namectl: namectl,
                                amountctl: amountctl,
                                values: value,
                                members: members,
                                groupName: widget.groupName,
                                onsave: () async => {
                                  group
                                      .deleteExpense(value['title'].toString()),
                                  group.addExpense(
                                    Expense(
                                      name: namectl.text,
                                      amount: double.parse(amountctl.text),
                                      paidBy: value['paidBy'],
                                    ),
                                  ),
                                  hiveService.updateGroup(
                                      widget.groupName, group),
                                  widget.delete(),
                                  Navigator.of(context).pop(),
                                },
                                oncancel: () => Navigator.of(context).pop(),
                              );
                            });
                      },
                      icon: Icons.edit,
                      backgroundColor: Colors.black87,
                      borderRadius: BorderRadius.circular(40)),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.payment_outlined,
                                size: 25,
                                // color: Colors.orange,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${value['title'].toString()}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'Paid By : ${value['paidBy']}',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ),
                        Text(
                          '\$${value['amount'].toString()}',
                          style: TextStyle(fontSize: 19),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
