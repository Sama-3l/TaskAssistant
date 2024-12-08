// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskassistant/business_logic/cubits/MarkCompletedCubit/mark_completed_cubit.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/extensions.dart';
import 'package:taskassistant/constants/sizes.dart';
import 'package:taskassistant/data/models/task.dart';
import 'package:taskassistant/data/models/user.dart';
import 'package:taskassistant/presentation/pages/add_page.dart';

class TaskElement extends StatelessWidget {
  TaskElement({super.key, required this.task, required this.user});

  TaskModel task;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => AddTaskPage(
                user: user,
                task: task,
                edit: true,
              ))),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(8), boxShadow: [
          BoxShadow(color: AppColors.black.withOpacity(0.1), blurRadius: 10)
        ]),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                task.completed = !task.completed;
                BlocProvider.of<MarkCompletedCubit>(context).onMark();
              },
              child: task.completed
                  ? const Icon(
                      CupertinoIcons.circle_fill,
                      size: 24,
                      color: AppColors.purple,
                    )
                  : const Icon(
                      CupertinoIcons.circle,
                      size: 24,
                      color: AppColors.purple,
                    ),
            ),
            kGap8,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    softWrap: true,
                    style: context.body.copyWith(
                      color: task.completed ? AppColors.black.withOpacity(0.4) : AppColors.black,
                      decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  Text(
                    DateFormat('d, MMM').format(task.deadline),
                    style: context.caption,
                  ),
                ],
              ),
            ),
            kGap16,
            task.completed
                ? Container(
                    decoration: BoxDecoration(color: CupertinoColors.activeGreen, borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "Done",
                      style: context.caption.copyWith(
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  )
                : Row(
                    children: task.tags
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Container(
                                decoration: BoxDecoration(color: task.color, borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text(
                                  e,
                                  style: context.caption.copyWith(
                                    color: AppColors.primaryWhite,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}
