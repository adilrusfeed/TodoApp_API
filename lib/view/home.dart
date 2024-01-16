// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(color: Colors.pink,child: Padding(
        padding: EdgeInsets.all(10),
       child: Column(        
        children:[
         
        ]
      ),),
     ) );
  }
}
 