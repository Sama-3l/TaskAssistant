import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskassistant/algorithms/methods.dart';
import 'package:taskassistant/business_logic/cubits/AddTaskCubit/add_task_cubit.dart';
import 'package:taskassistant/business_logic/cubits/ChangeDateCubit/change_date_cubit.dart';
import 'package:taskassistant/business_logic/cubits/MarkCompletedCubit/mark_completed_cubit.dart';
import 'package:taskassistant/business_logic/cubits/SignInSwitchCubit/sign_in_switch_cubit.dart';
import 'package:taskassistant/constants/theme.dart';
import 'package:taskassistant/firebase_options.dart';
import 'package:taskassistant/presentation/main_app.dart';
import 'package:taskassistant/presentation/screens/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final currUser = FirebaseAuth.instance.currentUser;
  Methods func = Methods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInSwitchCubit(),
          ),
          BlocProvider(
            create: (context) => MarkCompletedCubit(),
          ),
          BlocProvider(
            create: (context) => ChangeDateCubit(),
          ),
          BlocProvider(
            create: (context) => AddTaskCubit(),
          ),
        ],
        child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme,
            home: FutureBuilder(
                future: func.checkIfLoggedIn(currUser),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return AppScreen(user: snapshot.data!);
                  } else {
                    return OnBoarding();
                  }
                })));
  }
}
