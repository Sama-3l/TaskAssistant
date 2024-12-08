import 'package:flutter/cupertino.dart';
import 'package:taskassistant/algorithms/widget_decider.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/sizes.dart';
import 'package:taskassistant/presentation/widgets/textfield_element.dart';

class HeaderElement extends StatelessWidget {
  HeaderElement({super.key, required this.search});

  final TextEditingController search;
  final WidgetDecider wd = WidgetDecider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text('Doesn\'t Work'),
                    content: const Text('Sorry this doesn\'t work'),
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
            child: const Icon(
              CupertinoIcons.square_grid_2x2,
              size: 24,
              color: AppColors.primaryWhite,
            ),
          ),
          kGap16,
          Expanded(
            child: TextfieldElement(
              controller: search,
              prefix: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Icon(
                  CupertinoIcons.search,
                  size: 12,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          kGap16,
          GestureDetector(
            onTap: () {
              wd.showOptions(context);
            },
            child: const Icon(
              CupertinoIcons.ellipsis,
              size: 24,
              color: AppColors.primaryWhite,
            ),
          ),
        ],
      ),
    );
  }
}
