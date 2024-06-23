import 'package:fireconnct/services/hive_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/models/member.dart';

class MakePayment extends StatefulWidget {
  final String group;
  final VoidCallback paymentSave;
  final List<String> people;

  MakePayment({
    required this.group,
    required this.paymentSave,
    required this.people,
  }) {}

  final _moneyController = TextEditingController();

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  HiveDatabaseService hiveService = HiveDatabaseService();
  late String fromMemberName;
  late String toMemberName;

  @override
  void initState() {
    super.initState();
    fromMemberName = widget.people[0];
    toMemberName = widget.people[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Payment'),
        actions: [
          IconButton(
            onPressed: () async {
              double amount = double.parse(widget._moneyController.text);
              Group group = await hiveService.getGroup(widget.group);
              group.makePayment(fromMemberName, toMemberName, amount);
              await hiveService.updateGroup(widget.group, group);
              widget.paymentSave();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
              controller: widget._moneyController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From:", style: TextStyle(fontSize: 15)),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: fromMemberName,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              fromMemberName = newValue;
                            });
                          }
                        },
                        items: widget.people
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("To:", style: TextStyle(fontSize: 15)),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: toMemberName,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              toMemberName = newValue;
                            });
                          }
                        },
                        items: widget.people
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
