import 'package:flutter/cupertino.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/extensions.dart';
import 'package:taskassistant/data/models/task.dart';
import 'package:taskassistant/data/models/user.dart';
import 'package:taskassistant/presentation/pages/add_page.dart';
import 'package:taskassistant/presentation/screens/calendar.dart';
import 'package:taskassistant/presentation/screens/home.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key, required this.user});

  final UserModel user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CupertinoTabScaffold(
          tabBar: CupertinoTabBar(height: 56, items: [
            CupertinoIcons.list_bullet.toNavBarItem(),
            CupertinoIcons.calendar.toNavBarItem(),
          ]),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (context) => HomeScreen(
                    currUser: user,
                  ),
                );
              case 1:
                return CupertinoTabView(
                  builder: (context) => const CalendarScreen(),
                );
              default:
                return CupertinoTabView(
                  builder: (context) => HomeScreen(
                    currUser: user,
                  ),
                );
            }
          },
        ),
        Positioned(
          bottom: (MediaQuery.of(context).size.height * 0.075),
          child: CupertinoButton(
            borderRadius: BorderRadius.circular(40),
            color: AppColors.blue1,
            padding: const EdgeInsets.all(16),
            onPressed: () => Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                  builder: (context) => AddTaskPage(
                        user: user,
                        task: TaskModel(
                          title: "",
                          deadline: DateTime.now(),
                          tags: [],
                          color: AppColors.orangeTag,
                        ),
                      )),
            ),
            child: const Icon(
              CupertinoIcons.add,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ],
    );
  }
}
