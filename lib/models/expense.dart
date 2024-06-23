import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String paidBy;

  @HiveField(2)
  final double amount;

  Expense({ required this.name,required this.paidBy, required this.amount});
}