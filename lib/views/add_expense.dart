// ignore_for_file: prefer_const_constructors

import 'package:fireconnct/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/services/hive_database_service.dart';

class AddExpense extends StatefulWidget {
  final VoidCallback onSave;
  final String groupName;
  final List<String> members;

  AddExpense({
    required this.onSave,
    required this.members,
    required this.groupName,
  });

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late String selectedMember;
 HiveDatabaseService hiveService = HiveDatabaseService();

  @override
  void initState() {
    super.initState();
    selectedMember = widget.members[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              // Save button onPressed logic
              Group group = await hiveService.getGroup(widget.groupName);


                group.addExpense(
                  Expense(
                    name: _titleController.text,
                    amount: double.parse(_amountController.text),
                    paidBy: selectedMember,
                  ),
                );

                await hiveService.updateGroup(widget.groupName, group);
              

              widget.onSave();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            Row(
              children: [
                Text('Payment By:', style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 30,
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    value: selectedMember,
                    onChanged: (String? newValue) {
                      // When the user selects an item, update the selected item
                      if (newValue != null) {
                        setState(() {
                          selectedMember = newValue;
                        });
                      }
                    },
                    items: widget.members.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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