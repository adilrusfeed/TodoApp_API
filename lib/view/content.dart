// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_api/controller/provider.dart';



class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: Column(
          children: [
            Text(detailProvider.titleController.text),
            Text(detailProvider.discriptController.text),
          ],
        ),
      ),
    );
  }
}