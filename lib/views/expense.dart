import 'package:fireconnct/models/group.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: widget.expense.map((value) {
          return Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    Group group = await hiveService.getGroup(widget.groupName);
                    // print(group.expenses.indexOf(value));
                    // Add your delete function here
                    // print(widget.expense.indexOf(value));
                    group.deleteExpense(value['title'].toString());
                    await hiveService.updateGroup(widget.groupName, group);
                    widget.delete();
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                              color: Colors.orange,
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
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1.0,
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
