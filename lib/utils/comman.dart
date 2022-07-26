import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comman {

  //Sizebox for width
  static Widget sizeBoxwidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  //Sizebox for height
  static Widget sizeBoxheight(double height) {
    return SizedBox(
      height: height,
    );
  }


  //hide keyboard
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }


  static removeFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  //Show Snakbar without key
  static showSnakbar(String message, BuildContext context, Color backgroundColor) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        backgroundColor: backgroundColor,
        content: new Text(
          message,
          style: const TextStyle(
            fontFamily: 'SFUI-Display-Regular',
            fontSize: 16.0,
            color: Colors.white,
          ),
        )));
  }

  //Hide loading dialog
  static hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

}
