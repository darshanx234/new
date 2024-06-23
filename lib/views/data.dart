 
class  Userdata {


      
   static Map group = {
    'name':'Friends',
    'members'  : <String>['darshan' , 'pratham' , 'vandan'],
    'money':<double>[0.0 , 0.0 , 0.0],
    'expense':[],
    'payment':[{
      'formperson':'',
      'toperson':'',
      'amount':0
    }]
  };

// static List members = group['members'];
// static List value= group['money'];

List<String> get members => group['members'];
  // set members(List newMembers) => group['members'] = newMembers;
  List get value => group['money'];
  // set value(List newValue) => group['money'] = newValue;
  List get expense => group['expense'];

static List<String> person = group['members'];
static List money = group['money'];

static List expensea = group['expense'];

static List personmoney=[person , money];

 
List<String> options = List.generate(person.length, (index) => person[index].toString());
  
 

  // Iterate through the expenses list
  List experseop(List expenses){
  List amounts = [];
  List paidByList = [];

for (var  expense in expenses) {
    // Extract amount and paidBy information
    int amount = expense['amount'];
    String paidBy = expense['paidBy'];

    // Add to separate lists
    amounts.add(amount);
    paidByList.add(paidBy);
  }
 List combinedList = [];

  for (int i = 0; i < amounts.length && i < paidByList.length; i++) {
    combinedList.add([members[i] ,amounts[i]] );
  }

  
  return combinedList;
}
void splitmoney(){
 List<int> money = group['money'];
  List<Map<String, dynamic>> expenses = group['expense'];
for (var expense in Userdata.expensea) {
    String paidBy = expense['paidBy'];
    int amount = expense['amount'];

    // Find the index of the person in members list
    int personIndex = Userdata.person.indexOf(paidBy);

    if (personIndex != -1) {
      // Update the corresponding money in the 'money' list
      Userdata.money[personIndex] += amount;
      
    }
    // print(Userdata.money);
}
}}


