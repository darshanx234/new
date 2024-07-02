import 'package:fireconnct/models/expense.dart';
import 'package:fireconnct/models/group.dart';
import 'package:fireconnct/services/hive_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Expenseedit extends StatefulWidget {
  final TextEditingController namectl;
  final TextEditingController amountctl;
  final Map<String, dynamic> values;
  final List<String> members;
  final VoidCallback onsave;
  final VoidCallback oncancel;
  final String groupName;

  Expenseedit({
    Key? key,
    required this.namectl,
    required this.amountctl,
    required this.values,
    required this.members,
    required this.onsave,
    required this.oncancel,
    required this.groupName,
  }) : super(key: key);

  @override
  State<Expenseedit> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<Expenseedit> {
  late String selectedMember;

  late Group group;
  HiveDatabaseService hiveService = HiveDatabaseService();

  loadGroupData() async {
    group = await hiveService.getGroup(widget.groupName);
  }

  @override
  void initState() {
    super.initState();
    selectedMember = widget.members[0];
    loadGroupData();
  }

  @override
  Widget build(BuildContext context) {
    widget.namectl.text = widget.values['title'];
    widget.amountctl.text = widget.values['amount'].toString();

    return AlertDialog(
      content: Container(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: widget.namectl,
              decoration: const InputDecoration(
                hintText: "Enter Person name",
                labelText: "New Person",
              ),
            ),
            TextFormField(
              controller: widget.amountctl,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButton<String>(
                value: selectedMember,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedMember = newValue;
                    });
                  }
                },
                items: widget.members
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () async {
                    group.deleteExpense(widget.values['title'].toString());
                    group.addExpense(
                      Expense(
                        name: widget.namectl.text,
                        amount: double.parse(widget.amountctl.text),
                        paidBy: selectedMember,
                      ),
                    );
                    await hiveService.updateGroup(widget.groupName, group);
                    // widget.onsave();
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
