class Group {
  String name;
  List<Member> members;
  List<Expense> expenses;

  Group({
    required this.name,
    required this.members,
    required this.expenses,
  });

  void splitMoney() {
    for (var expense in expenses) {
      // Find the member who paid
      Member? payer = members.firstWhere((member) => member.name == expense.paidBy);
  
      if (payer != null) {
        // Calculate the split amount
        double splitAmount = expense.amount / members.length;
  
        // Each member owes the payer the split amount
        for (var member in members) {
          if (member.name != payer.name) {
            member.owes[payer.name] = (member.owes[payer.name] ?? 0) + splitAmount;
            member.money -= splitAmount; // Decrease the member's money
          } else {
            // Update the payer's money
            member.money += expense.amount - splitAmount; // Decrease the payer's money by the amount they are owed
          }
        }
      }
    }
  }
}

class Member {
  String name;
  double money;
  Map<String, double> owes; // Maps the name of another member to the amount this member owes them

  Member({
    required this.name,
    required this.money,
    required this.owes,
  });
}

class Expense {
  String paidBy;
  double amount;

  Expense({
    required this.paidBy,
    required this.amount,
  });
}