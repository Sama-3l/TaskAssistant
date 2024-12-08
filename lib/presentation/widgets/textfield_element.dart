import 'package:flutter/cupertino.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/extensions.dart';

class TextfieldElement extends StatelessWidget {
  const TextfieldElement({
    super.key,
    this.title,
    required this.controller,
    this.suffix,
    this.prefix,
    this.obscureText = false,
    this.maxLength = false,
  });

  final String? title;
  final TextEditingController controller;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscureText;
  final bool maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  title!,
                  style: context.bodyPlaceholder.copyWith(fontSize: 12),
                )
              : Container(),
          CupertinoTextField(
            maxLines: 1,
            controller: controller,
            maxLength: maxLength ? 20 : 100,
            decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: AppColors.black.withOpacity(0.3),
                )),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8), // Add left padding to avoid overlap with icon
            style: context.body,
            placeholderStyle: context.body.copyWith(
              color: context.body.color!.withOpacity(0.3),
            ),
            suffix: suffix,
            obscureText: obscureText,
            prefix: prefix,
          ),
        ],
      ),
    );
  }
}
