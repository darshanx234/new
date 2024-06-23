void main(){
  
  
  Map group = {
    'groupName': 'xyz',
    'groupmembers': ['darshan','pratham' , 'raj'],
    'overallmoney' : [3 , 25 ,20],
    'totalperson' : 3,
    'darshan' : 25,
    'raj':20,
    'pratham':30,
    'expenses':[
      {
       'name':'food',
        'amount': 500,
        'by':['darshan'],
        'for':['darshan','pratham','raj']
      }
    ],
    'payment' :[{
      'amount': 100,
      'from': 'darshan',
      'to':'raj'}
    ]
    
  };
  
  
 
  List members = group['groupmembers'];
  
  List overmoney = group['overallmoney'];
  members.forEach((number) {
    print(number);
  });
  
  
 List<Map<String, dynamic>> personMoneyList = List.generate(
  members.length,
  (index) => {'person': members[index], 'money': overmoney[index]},
);
  print(personMoneyList);
  
  
  
 void addperson(List <Map<String , dynamic>> a , String person , double value ){
   Map<String ,dynamic> personval = {
     'person' : person,
     'money' : value,
   };
   
   a.add(personval);
   
 }
  addperson(personMoneyList , 'jainam' , 0);
  
  print(personMoneyList);
  
                 
                 
                 
                 
  // print(Overview);
  
   //Overview.add({'name':'darshanx'});
   //print(Overview);
  
  
  
  
  
  
  // addmember(name:'akhil');
 
  // print(group);
}

// File: my_class.dart

class MyClass {
  // Public variable
  String publicVariable = 'Hello from MyClass!';

  // Public method
  void publicMethod() {
    print('Public method in MyClass.');
  }
}
