import 'package:flutter/material.dart';

class todo extends StatelessWidget {
  const todo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: ListTile(
              title: Text("hello" ,style: TextStyle(fontSize: 20),),
              trailing: Icon(Icons.person_2),
            ),
          );
        },
      ),
    );
  }
}