// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:taskassistant/data/models/task.dart';

class UserModel {
  String name;
  String email;
  List<TaskModel> setTasks;
  List<TaskModel> completedTasks;
  List<TaskModel>? incompleteTasks;

  UserModel({
    required this.name,
    required this.email,
    required this.setTasks,
    required this.completedTasks,
    this.incompleteTasks,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'setTasks': setTasks.map((x) => x.toJson()).toList(),
      'completedTasks': completedTasks.map((x) => x.toJson()).toList(),
      'incompleteTasks': incompleteTasks == null ? [] : incompleteTasks!.map((x) => x.toJson()).toList(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      setTasks: (map['setTasks'] as List).map((e) => TaskModel.fromJson(e)).toList(),
      completedTasks: (map['completedTasks'] as List).map((e) => TaskModel.fromJson(e)).toList(),
      incompleteTasks: map['incompleteTasks'] != null ? (map['incompleteTasks'] as List).map((e) => TaskModel.fromJson(e)).toList() : null,
    );
  }
}
