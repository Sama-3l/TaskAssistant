import 'package:flutter/cupertino.dart';
import 'package:taskassistant/constants/colors.dart';

class CheckMarkElement extends StatelessWidget {
  const CheckMarkElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(color: AppColors.blue1, borderRadius: BorderRadius.circular(32)),
        child: const Center(
          child: Icon(
            CupertinoIcons.checkmark_alt,
            size: 64,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}
