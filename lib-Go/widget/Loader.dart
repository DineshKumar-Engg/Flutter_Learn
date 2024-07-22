import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
    builder: (BuildContext context) {
      // Displaying a loading spinner
      return  AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        content: Row(
          children: [
            const CircularProgressIndicator(color: primary,),
            const SizedBox(width: 20),
            Text('Loading...',style: inputtxt,),
          ],
        ),
      );
    },
  );

  // Close the dialog after 3 seconds
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop(); // Close the dialog
  });
}