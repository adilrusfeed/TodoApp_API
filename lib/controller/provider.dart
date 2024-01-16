import 'package:flutter/material.dart';
import 'package:todoapp_api/model/model.dart';
import 'package:todoapp_api/service/service.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptController = TextEditingController();
  TodoService todoservice = TodoService();
  List<TodoModel> todolist = [];

  void getTodo() async {
    try {
      todolist = await todoservice.getData();
      notifyListeners();
    } catch (e) {
      Exception;
    }
    notifyListeners();
  }

  createTodo() async {
    try {
      await todoservice.cretedata(TodoModel(
          title: titleController.text, discription: discriptController.text));
      getTodo();
    } catch (e) {
      return null;
    }
  }

  deleteTodo(id) async {
    try {
      await todoservice.deletedata(id: id);
      getTodo();
    } catch (e) {
      return null;
    }
  }

  editTodo(id, title, discription) async {
    try {
      await todoservice.updatedata(
          TodoModel(title: title, discription: discription), id);
      getTodo();
    } catch (e) {
      return null;
    }
  }
}
