// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireconnct/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';


class Nevbar extends StatelessWidget {
  const Nevbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
       child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:  Text("splid" , style: TextStyle(fontSize: 20 , fontWeight : FontWeight.bold) ),
          accountEmail: Text('') ,
          currentAccountPicture: CircleAvatar(
            child: ClipOval(child: Image.network("data:image/jpeg;base64,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", 
            width: 90 , height: 90,)),
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 33, 48, 53),
          ),
          )
         , ListTile(
            leading:  Icon(Icons.info_outline_rounded),
            title: Text("My Profile"),
            onTap: () {
              print('fav');
            }
          )
          , ListTile(
            leading:  Icon(Icons.diamond),
            title: Text("Primium"),
            onTap: () {
              print('fav');
            }
          )
          , ListTile(
            leading:  Icon(Icons.favorite),
            title: Text("Favorite"),
            onTap: () {
              print('fav');
            }
          )
          , ListTile(
            leading:  Icon(Icons.star_border_outlined),
            title: Text("Rate Us"),
           
          ),
          
            ListTile(
              leading:  Icon(Icons.logout_outlined),
              title: Text("LogOut"),
              onTap: ()  {
              
                
                    try{
                     FirebaseAuth.instance.signOut();
                      navigator?.pushReplacement(MaterialPageRoute(builder:  (BuildContext context) => HomeScreen() ));
                    }
                    // ignore: empty_catches
                    catch(e){

                    }
                
                
               
              }
            ),
          
        ],
       ),
    );
  }
}