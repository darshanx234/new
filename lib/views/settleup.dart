import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/services/hive_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class SettleUp extends StatefulWidget {
  List transactions;
  String groupName;
  VoidCallback updateState;
  SettleUp(
      {required this.transactions,
      required this.groupName,
      required this.updateState});

  @override
  State<SettleUp> createState() => _SettleUpState();
}

class _SettleUpState extends State<SettleUp> {
  HiveDatabaseService hiveService = HiveDatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settle Up"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              widget.updateState();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: widget.transactions.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      print('Yes tapped');
                      Group g = await hiveService.getGroup(widget.groupName);
                      g.makePayment(
                          widget.transactions[index]['from'],
                          widget.transactions[index]['to'],
                          widget.transactions[index]['money']);
                      await hiveService.updateGroup(widget.groupName, g);
                      widget.updateState();
                      setState(() {
                        widget.transactions.removeAt(index);
                      });
                    },
                    // label: 'Yes',
                    icon: Icons.check,
                    backgroundColor: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
              child: Container(
                // color: Colors.white,
                child: ListTile(
                  title: Text('From: ${widget.transactions[index]['from']}'),
                  subtitle: Text('To: ${widget.transactions[index]['to']}'),
                  trailing: Text(
                    '\$${double.parse(widget.transactions[index]['money'].toString()).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
