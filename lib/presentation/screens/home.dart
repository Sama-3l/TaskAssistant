import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskassistant/algorithms/methods.dart';
import 'package:taskassistant/business_logic/cubits/AddTaskCubit/add_task_cubit.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/extensions.dart';
import 'package:taskassistant/constants/sizes.dart';
import 'package:taskassistant/data/models/user.dart';
import 'package:taskassistant/presentation/widgets/home_elements/header_element.dart';
import 'package:taskassistant/presentation/widgets/home_elements/tasks_list_element.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.currUser,
  });

  final UserModel currUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController search = TextEditingController();
  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.secondaryWhite,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              color: AppColors.blue2,
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                HeaderElement(search: search),
                kGap16,
                Text(
                  func.formatDate(DateTime.now()),
                  style: context.caption.copyWith(color: AppColors.primaryWhite),
                ),
                kGap4,
                Text(
                  "My tasks",
                  style: context.title.copyWith(color: AppColors.primaryWhite),
                ),
                kGap8,
              ]),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: widget.currUser.setTasks.isEmpty
                        ? Center(
                            child: Text(
                              "No Tasks Yet",
                              style: context.title,
                            ),
                          )
                        : BlocBuilder<AddTaskCubit, AddTaskState>(
                            builder: (context, state) {
                              return TaskListScreen(
                                tasks: widget.currUser.setTasks,
                                user: widget.currUser,
                              );
                            },
                          )))
          ],
        ),
      ),
    );
  }
}
