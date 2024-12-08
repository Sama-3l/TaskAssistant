import 'package:flutter/cupertino.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:taskassistant/constants/colors.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String icon;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Iconify(
          icon,
          size: 24,
          color: AppColors.primaryWhite,
        ),
      ),
    );
  }
}
