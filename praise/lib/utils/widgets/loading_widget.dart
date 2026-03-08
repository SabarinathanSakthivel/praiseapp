import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';

class LoadingAlertDialog {
  late BuildContext dialogContext;

  onLoading(BuildContext context) {
    dialogContext = context;
    return showDialog(
      context: dialogContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: ,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: const EdgeInsets.all(0.0),
          insetPadding: const EdgeInsets.symmetric(horizontal: 100),
          content: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: primaryBlue,
                ),
                const SizedBox(height: 16),
                Text("Please wait....", style: black14BoldTextStyle),
              ],
            ),
          ),
        );
      },
    );
  }

  onStopping() {
    Navigator.pop(dialogContext, true);
  }
}
