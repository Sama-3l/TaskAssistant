// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskassistant/algorithms/methods.dart';
import 'package:taskassistant/business_logic/cubits/AddTaskCubit/add_task_cubit.dart';
import 'package:taskassistant/business_logic/cubits/ChangeDateCubit/change_date_cubit.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/extensions.dart';
import 'package:taskassistant/constants/sizes.dart';
import 'package:taskassistant/data/models/task.dart';
import 'package:taskassistant/data/models/user.dart';
import 'package:taskassistant/presentation/widgets/color_choice_element.dart';
import 'package:taskassistant/presentation/widgets/date_picker.dart';
import 'package:taskassistant/presentation/widgets/textfield_element.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({
    super.key,
    required this.user,
    required this.task,
    this.edit = false,
  });

  final UserModel user;
  final TaskModel task;
  final bool edit;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final Methods func = Methods();

  final TextEditingController task = TextEditingController();

  final TextEditingController tag1 = TextEditingController();

  final TextEditingController tag2 = TextEditingController();

  final TextEditingController tag3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    task.text = widget.task.title;
    if (widget.edit) {
      tag1.text = widget.task.tags[0];
      tag2.text = widget.task.tags[1];
      tag3.text = widget.task.tags[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.secondaryWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 56,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            color: AppColors.blue2,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(
                func.formatDate(DateTime.now()),
                style: context.caption.copyWith(color: AppColors.primaryWhite),
              ),
              kGap4,
              Text(
                "Add New Task",
                style: context.title.copyWith(color: AppColors.primaryWhite),
              ),
              kGap8,
            ]),
          ),
          kGap24,
          TextfieldElement(title: "Task Title", controller: task),
          kGap16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<ChangeDateCubit, ChangeDateState>(
              builder: (context, state) {
                return CupertinoDatePickerWidget(
                  initialDate: widget.task.deadline,
                  minimumDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  maximumDate: DateTime(3000),
                  onDateSelected: (dateTime) {
                    widget.task.deadline = dateTime;
                    BlocProvider.of<ChangeDateCubit>(context).onChangeDate();
                  },
                );
              },
            ),
          ),
          kGap16,
          TextfieldElement(
            title: "Tag1",
            controller: tag1,
            maxLength: true,
          ),
          kGap16,
          TextfieldElement(
            title: "Tag2",
            controller: tag2,
            maxLength: true,
          ),
          kGap16,
          TextfieldElement(
            title: "Tag3",
            controller: tag3,
            maxLength: true,
          ),
          kGap16,
          ColorChooser(
            colors: [
              AppColors.orangeTag,
              AppColors.redTag,
              AppColors.purple
            ],
            onColorSelected: (color) {
              widget.task.color = color;
            },
            index: widget.task.color == AppColors.orangeTag
                ? 0
                : widget.task.color == AppColors.redTag
                    ? 1
                    : 2,
          ),
          kGap40,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              child: CupertinoButton(
                  padding: const EdgeInsets.only(top: 8),
                  color: AppColors.purple,
                  child: Text(
                    widget.edit ? "Edit Task" : "Add Task",
                    style: context.button,
                  ),
                  onPressed: () async {
                    widget.task.title = task.value.text;
                    widget.task.tags = [
                      tag1.value.text,
                      tag2.value.text,
                      tag3.value.text,
                    ];
                    if (!widget.edit) {
                      widget.user.setTasks.add(widget.task);
                    }
                    final querySnapshot = await FirebaseFirestore.instance
                        .collection('users') // Replace with your collection name
                        .where('email', isEqualTo: widget.user.email)
                        .limit(1) // Ensure you only fetch one matching document
                        .get();
                    final docRef = querySnapshot.docs.first.reference;
                    docRef.update({
                      'setTasks': widget.user.setTasks.map((e) => e.toJson()).toList()
                    });
                    BlocProvider.of<AddTaskCubit>(context).onTaskAdd();
                    Navigator.of(context).pop();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
