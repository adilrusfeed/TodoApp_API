import 'package:dio/dio.dart';
import 'package:todoapp_api/model/model.dart';

class TodoService {
  Dio dio = Dio();
  var endpointUrl = "https://65a2649a42ecd7d7f0a786cd.mockapi.io/TodoApp";

  Future<List<TodoModel>> getData() async {
    try {
      Response response = await dio.get(endpointUrl);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<TodoModel> data = jsonList.map((json) {
          return TodoModel.fromJson(json);
        }).toList();
        return data;
      } else {
        throw Exception("Failed to load App");
      }
    } catch (error) {
      throw Exception("Failed to load App:$error");
    }
  }

  cretedata(TodoModel value) async {
    try {
      await dio.post(endpointUrl, data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  updatedata(TodoModel value, String id) async {
    try {
      await dio.put('$endpointUrl/$id', data: value.toJson());
    } catch (e) {
      Exception();
    }
  }

  deletedata({required id}) async {
    var deleteurl = '$endpointUrl/$id';
    try {
      await dio.delete(deleteurl);
    } catch (e) {
      Exception();
    }
  }
}
