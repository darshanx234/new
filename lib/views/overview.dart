import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  List overall;
  Overview({super.key ,
  required this.overall });

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: widget.overall.map((value) {
          return Column(
            children: [
              
              Container(
                child: Padding(
                  padding: const EdgeInsets.only( top:15 , left :10 , right: 10 , bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${value['name'].toString()} ' , style: TextStyle(fontSize: 16.0), ),
                      Text('\$${double.parse(value['money'].toStringAsFixed(2)).toString()}' , style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold), )
                      
                    ] ,
                  ),
                ),
              ),
              Divider(
                    color: Colors.grey.shade400,
                    thickness: 1.0,
                  )
            ],
          );
          
        }).toList(),
      ),
    );
  }
}