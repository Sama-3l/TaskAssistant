import 'package:flutter/cupertino.dart';
import 'colors.dart';

extension FontWeightExtension on BuildContext {
  TextStyle get extraLight => CupertinoTheme.of(this).textTheme.textStyle.copyWith(fontFamily: "Fustat-ExtraLight");

  TextStyle get light => CupertinoTheme.of(this).textTheme.textStyle.copyWith(fontFamily: "Fustat-Light");

  TextStyle get regular => CupertinoTheme.of(this).textTheme.textStyle.copyWith(fontFamily: "Fustat-Regular");

  TextStyle get medium => CupertinoTheme.of(this).textTheme.textStyle.copyWith(fontFamily: "Fustat-Medium");

  TextStyle get semiBold => CupertinoTheme.of(this).textTheme.textStyle.copyWith(fontFamily: "Fustat-SemiBold");

  TextStyle get bold => CupertinoTheme.of(this).textTheme.textStyle.copyWith(fontFamily: "Fustat-Bold");

  TextStyle get extraBold => CupertinoTheme.of(this).textTheme.textStyle.copyWith(fontFamily: "Fustat-ExtraBold");
}

extension UIThemeExtension on BuildContext {
  // TextStyle get biggestTitle => bold.copyWith(
  //       fontSize: 32,
  //       letterSpacing: -2.5,
  //       color: AppColors.secondaryWhite,
  //     );

  TextStyle get title => extraBold.copyWith(
        fontSize: 24,
        color: AppColors.black,
      );

  TextStyle get heading => bold.copyWith(fontSize: 18, letterSpacing: -0.5, color: AppColors.black);

  TextStyle get bodyPlaceholder => medium.copyWith(fontSize: 16, color: AppColors.black.withOpacity(0.4));

  TextStyle get button => extraBold.copyWith(fontSize: 16, color: AppColors.primaryWhite, letterSpacing: 0.5);

  TextStyle get body => medium.copyWith(fontSize: 16, color: AppColors.black);

  TextStyle get caption => medium.copyWith(fontSize: 10, color: AppColors.black.withOpacity(0.4));

  // TextStyle get accName => extraBold.copyWith(
  //       fontSize: 24,
  //       letterSpacing: -1,
  //       color: AppColors.primaryWhite,
  //     );

  // TextStyle get accRollNum => light.copyWith(
  //       fontSize: 16,
  //       letterSpacing: -0.5,
  //       color: AppColors.primaryWhite,
  //     );

  // TextStyle get heading => extraBold.copyWith(
  //       fontSize: 16,
  //       letterSpacing: -0.5,
  //       color: AppColors.primaryWhite,
  //     );

  // TextStyle get heading2 => semiBold.copyWith(
  //       fontSize: 16,
  //       letterSpacing: -0.5,
  //       color: AppColors.primaryWhite,
  //     );

  // TextStyle get headingWhite => extraBold.copyWith(
  //       fontSize: 16,
  //       letterSpacing: -0.5,
  //       color: AppColors.secondaryWhite,
  //     );

  // TextStyle get subHeading => bold.copyWith(
  //       fontSize: 16,
  //       letterSpacing: -0.5,
  //       color: AppColors.primaryWhite,
  //     );

  // TextStyle get label => extraBold.copyWith(
  //       fontSize: 12,
  //       letterSpacing: -0.5,
  //       color: AppColors.backgroundBlack,
  //     );

  // TextStyle get buttonText => extraBold.copyWith(
  //       fontSize: 16,
  //       letterSpacing: -0.5,
  //       color: AppColors.backgroundBlack,
  //     );

  // TextStyle get labelWhite => extraBold.copyWith(
  //       fontSize: 12,
  //       letterSpacing: -0.5,
  //       color: AppColors.secondaryWhite,
  //     );

  // TextStyle get body => medium.copyWith(
  //       fontSize: 12,
  //       letterSpacing: -0.2,
  //       color: AppColors.primaryWhite,
  //     );

  // TextStyle get chatText => medium.copyWith(
  //       fontSize: 16,
  //       letterSpacing: -0.3,
  //       color: AppColors.primaryWhite,
  //     );

  // // TextStyle get caption => medium.copyWith(
  // //       fontSize: 12,
  // //       letterSpacing: -0.5,
  // //       color: AppColors.secondaryWhite.withOpacity(0.75),
  // //     );

  // TextStyle get tag => medium.copyWith(
  //       fontSize: 8,
  //       color: AppColors.primaryWhite,
  //     );

  // TextStyle get action => bold.copyWith(
  //       fontSize: 8,
  //       color: AppColors.backgroundBlack,
  //     );

  // TextStyle get note => medium.copyWith(
  //       fontSize: 10,
  //     );
}

extension BottomNavItemExtension on IconData {
  BottomNavigationBarItem toNavBarItem() {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(
          this, // "this" refers to the IconData instance
          size: 24,
        ),
      ),
    );
  }
}
