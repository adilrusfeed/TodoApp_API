// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_api/controller/provider.dart';
import 'package:todoapp_api/view/content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Expanded(child: Consumer<TodoProvider>(
              builder: (context, value, child) {
                value.getTodo();
                return value.todolist.isEmpty
                    ? Lottie.asset("assets/empty lottie.json")
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final data = value.todolist.length - index - 1;
                          final todo = value.todolist[data];
                          return GestureDetector(
                            onTap: () {
                              // Set controllers with the values of the selected todo
                              final todo = value.todolist[data];
                              Provider.of<TodoProvider>(context, listen: false)
                                  .titleController
                                  .text = todo.title.toString();
                              Provider.of<TodoProvider>(context, listen: false)
                                  .discriptController
                                  .text = todo.discription.toString();

                              // Navigate to ContentPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContentPage(),
                                ),
                              );
                            },
                            child: Card(
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        todo.title.toString().trim(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                var id = todo.id;
                                                value.deleteTodo(id);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                editScreen(
                                                    todo.title.toString(),
                                                    todo.discription.toString(),
                                                    todo.id,
                                                    context);
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              )),
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          );
                        },
                        itemCount: value.todolist.length,
                      );
              },
            ))
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addScreen(context) {
    final todoprovider = Provider.of<TodoProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "Add Data",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: todoprovider.titleController,
              decoration: InputDecoration(
                labelText: "Enter the title...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              maxLines: 5,
              controller: todoprovider.discriptController,
              decoration: InputDecoration(
                labelText: "Enter the subject",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    todoprovider.createTodo();
                    Navigator.pop(context);
                    todoprovider.titleController.clear();
                    todoprovider.discriptController.clear();

                    // Show SnackBar after adding a new todo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Added successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  editScreen(String title, String discription, id, context) {
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController discrController =
        TextEditingController(text: discription);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Edit the todo"),
            content: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Title"),
                ),
                TextFormField(
                  controller: discrController,
                  decoration: InputDecoration(labelText: "Discription"),
                ),
                ElevatedButton(
                  onPressed: () {
                    String newTitle = titleController.text.trim();
                    String newDiscription = discrController.text.trim();
                    Provider.of<TodoProvider>(context, listen: false)
                        .editTodo(id, newTitle, newDiscription);
                    Navigator.pop(context);
                  },
                  child: Text("Update"),
                )
              ],
            ));
      },
    );
  }
}
