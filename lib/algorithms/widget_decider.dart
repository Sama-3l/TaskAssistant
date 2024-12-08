import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class WidgetDecider {
  void showOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Choose an Option'),
          message: const Text('Please select one of the options below.'),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Sign Out'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
