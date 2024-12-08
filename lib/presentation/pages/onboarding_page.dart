import 'package:flutter/cupertino.dart';
import 'package:taskassistant/constants/extensions.dart';
import 'package:taskassistant/constants/sizes.dart';
import 'package:taskassistant/presentation/widgets/check_mark_element.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CheckMarkElement(),
            kGap40,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.title,
                ),
                Text(
                  subtitle,
                  style: context.bodyPlaceholder,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
