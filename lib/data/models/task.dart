// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

class TaskModel {
  String title;
  DateTime deadline;
  Color color;
  List<String> tags;
  bool completed;

  TaskModel({
    required this.title,
    required this.deadline,
    required this.tags,
    required this.color,
    this.completed = false,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'deadline': deadline.millisecondsSinceEpoch,
      'color': color.value,
      'tags': tags,
      'completed': completed,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
      color: Color(map['color'] as int),
      tags: (map['tags'] as List).map((e) => e.toString()).toList(),
      // tags: List<String>.from((map['tags'] as List<String>)),
      completed: map['completed'] as bool,
    );
  }
}
