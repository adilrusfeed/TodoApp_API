// ignore_for_file: prefer_collection_literals

class TodoModel {
  String? id;
  String? discription;
  String? title;

  TodoModel({this.id,required this.discription,required this.title});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'], discription: json['discription'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["discription"] = discription;
    data["title"] = title;
    return data;
  }
}
