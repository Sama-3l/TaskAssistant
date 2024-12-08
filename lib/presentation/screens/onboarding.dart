import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/presentation/pages/onboarding_page.dart';
import 'package:taskassistant/presentation/screens/signUp.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: OnBoardingSlider(
        headerBackgroundColor: AppColors.primaryWhite,
        finishButtonText: 'Register',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: AppColors.blue1,
        ),
        skipTextButton: const Text('Skip'),
        trailing: const Text('Login'),
        onFinish: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const SignUpScreen())),
        background: [
          Container(
            color: AppColors.primaryWhite,
          ),
          Container(
            color: AppColors.primaryWhite,
          ),
          Container(
            color: AppColors.primaryWhite,
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: const [
          OnboardingPage(title: 'Prioritize Important Tasks', subtitle: 'Arrange your tasks in \n priority order'),
          OnboardingPage(title: 'Track Progress', subtitle: 'Track progress of multiple \n tasks through your time'),
          OnboardingPage(
            title: 'Get Things Done',
            subtitle: 'just a click away \n from planning your day',
          )
        ],
      ),
    );
  }
}
