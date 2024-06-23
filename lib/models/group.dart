import 'dart:math';

import 'package:hive/hive.dart';
import 'package:fireconnct/models/member.dart';
import 'package:fireconnct/models/expense.dart';

part 'group.g.dart';

@HiveType(typeId: 2)
class Group extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  List<Member> members;

  @HiveField(2)
  List<Expense> expenses;

  Group({required this.name, required this.members, required this.expenses});

  void addExpense(Expense expense) {
    expenses.add(expense);
    splitMoney(expense);
  }

  void splitMoney(Expense expense) {
    print('Splitting money');
    if (members.isNotEmpty) {
      var payer = members.firstWhere((member) => member.name == expense.paidBy);
      var splitAmount = expense.amount / members.length;

      for (var member in members) {
        if (member.name == payer.name) {
          member.money += expense.amount - splitAmount;
        } else {
          member.money -= splitAmount;
        }
      }
    }
  }

  void makePayment(String from, String to, double amount) {
    var payer = members.firstWhere((member) => member.name == from);
    var payee = members.firstWhere((member) => member.name == to);

    payer.money -= amount;
    payee.money += amount;
  }

  void deleteExpense(String expenseName) {
    Expense expense =
        expenses.firstWhere((expense) => expense.name == expenseName);
    print(expense);
    expenses.remove(expense);
    unsplitMoney(expense);
  }

  void unsplitMoney(Expense expense) {
    var payer = members.firstWhere((member) => member.name == expense.paidBy);
    var splitAmount = expense.amount / members.length;

    for (var member in members) {
      if (member.name == payer.name) {
        member.money -= expense.amount - splitAmount;
      } else {
        member.money += splitAmount;
      }
    }
  }
}
