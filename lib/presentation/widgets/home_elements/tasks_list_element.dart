// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskassistant/algorithms/methods.dart';
import 'package:taskassistant/business_logic/cubits/MarkCompletedCubit/mark_completed_cubit.dart';
import 'package:taskassistant/constants/extensions.dart';
import 'package:taskassistant/constants/sizes.dart';
import 'package:taskassistant/data/models/task.dart';
import 'package:taskassistant/data/models/user.dart';
import 'package:taskassistant/presentation/widgets/home_elements/task_element.dart';

class TaskListScreen extends StatelessWidget {
  final List<TaskModel> tasks;
  UserModel user;

  TaskListScreen({
    required this.tasks,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    Methods func = Methods();
    Map<String, List<TaskModel>> categorizedTasks = func.bifurcateTasks(tasks);

    return ListView.builder(
      itemCount: categorizedTasks.length,
      padding: EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        String category = categorizedTasks.keys.elementAt(index);
        List<TaskModel> categoryTasks = categorizedTasks[category] ?? [];

        return categoryTasks.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      category,
                      style: context.heading,
                    ),
                  ),
                  ...categoryTasks.map((task) {
                    return Column(
                      children: [
                        BlocBuilder<MarkCompletedCubit, MarkCompletedState>(
                          builder: (context, state) {
                            return TaskElement(
                              task: task,
                              user: user,
                            );
                          },
                        ),
                        kGap8,
                      ],
                    );
                  }),
                ],
              );
      },
    );
  }
}
