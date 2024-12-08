import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskassistant/algorithms/methods.dart';
import 'package:taskassistant/assets/svgs/svgs.dart';
import 'package:taskassistant/business_logic/cubits/SignInSwitchCubit/sign_in_switch_cubit.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/extensions.dart';
import 'package:taskassistant/constants/sizes.dart';
import 'package:taskassistant/data/models/user.dart';
import 'package:taskassistant/presentation/main_app.dart';
import 'package:taskassistant/presentation/widgets/check_mark_element.dart';
import 'package:taskassistant/presentation/widgets/social_media_login.dart';
import 'package:taskassistant/presentation/widgets/textfield_element.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final Methods func = Methods();
  bool signIn = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 56, right: 16, left: 16),
        child: SafeArea(
          child: BlocBuilder<SignInSwitchCubit, SignInSwitchState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CheckMarkElement(),
                  kGap40,
                  Text(
                    signIn ? "Get Started" : "Welcome back!",
                    style: context.title,
                  ),
                  kGap24,
                  TextfieldElement(title: "Email address", controller: email),
                  kGap16,
                  TextfieldElement(
                    title: "Password",
                    controller: password,
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        CupertinoIcons.eye_slash,
                        size: 16,
                        color: AppColors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  kGap16,
                  CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      borderRadius: BorderRadius.circular(24),
                      color: AppColors.blue1,
                      child: Text(
                        signIn ? "Sign Up" : "Log in",
                        style: context.button,
                      ),
                      onPressed: () async {
                        String email = this.email.value.text;
                        String password = this.password.value.text;
                        final user = signIn ? await func.signUpWithEmail(email, password) : await func.signInWithEmail(email, password);
                        if (user == null) {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Error'),
                                content: const Text('Invalid Credentials'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      // Handle the OK button press
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          final currUser = UserModel(
                            name: user.user!.displayName!,
                            email: user.user!.email!,
                            setTasks: [],
                            completedTasks: [],
                          );
                          if (!(await func.checkIfEmailExists(user.user!.email!))) {
                            await FirebaseFirestore.instance.collection('users').add(currUser.toJson());
                          }
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => AppScreen(
                                    user: currUser,
                                  )));
                        }
                      }),
                  kGap40,
                  Text(
                    "or log in with",
                    style: context.bodyPlaceholder,
                  ),
                  kGap16,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SocialMediaLogin(
                        icon: facebook,
                        color: CupertinoColors.systemBlue,
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Auth Not Allowed'),
                                content: const Text('We don\'t have this integrated yet.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      // Handle the OK button press
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      kGap16,
                      SocialMediaLogin(
                          icon: google,
                          color: CupertinoColors.systemRed,
                          onTap: () async {
                            final user = await func.signInWithGoogle();
                            UserModel? currUser = UserModel(
                              name: user.user!.displayName!,
                              email: user.user!.email!,
                              setTasks: [],
                              completedTasks: [],
                            );
                            if (!(await func.checkIfEmailExists(currUser.email))) {
                              await FirebaseFirestore.instance.collection('users').add(currUser.toJson());
                            } else {
                              currUser = await func.fetchUserDataByEmail(currUser.email);
                            }
                            if (currUser != null) {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => AppScreen(
                                        user: currUser!,
                                      )));
                            } else {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Sign Up Error'),
                                    content: const Text('Something went wrong'),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          // Handle the OK button press
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                      kGap16,
                      SocialMediaLogin(
                        icon: apple,
                        color: CupertinoColors.black,
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Auth Not Allowed'),
                                content: const Text('We don\'t have this integrated yet.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      // Handle the OK button press
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          signIn ? "Already have an account " : "Don't have an account? ",
                          style: context.caption,
                        ),
                        kGap4,
                        GestureDetector(
                          onTap: () {
                            signIn = !signIn;
                            BlocProvider.of<SignInSwitchCubit>(context).onSwitchEvent();
                          },
                          child: Text(
                            signIn ? "Log In" : "Get started!",
                            style: context.caption.copyWith(color: AppColors.blue1),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
