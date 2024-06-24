import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/models/member.dart';
import 'package:fireconnct/services/hive_database_service.dart';
import 'package:fireconnct/views/settleup.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  final List overall;
  String groupName;
  late VoidCallback updateState;
  Overview(
      {Key? key,
      required this.overall,
      required this.groupName,
      required this.updateState})
      : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  HiveDatabaseService hiveService = HiveDatabaseService();
  late Group group;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...widget.overall.map<Widget>((value) {
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
                        '${value['name'].toString()} ',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        '\$${double.parse(value['money'].toString()).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                // color: Colors.grey.shade400,
                thickness: 1.0,
              )
            ],
          );
        }).toList(),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                group = await hiveService.getGroup(widget.groupName);
                print(group.members.length);

                // Create a copy of the members list
                List<Member> membersCopy =
                    group.members.map((member) => Member.copy(member)).toList();

                var a = group.generateTransactions(membersCopy);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettleUp(
                          transactions: a,
                          groupName: widget.groupName,
                          updateState: widget.updateState)),
                );
              },
              child: Text("Settle Up"),
            ),
          ),
        )
      ],
    );
  }
}
