import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/widgets/buttons/filled_btn.dart';
import 'package:appentus_project/widgets/buttons/outlinedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:textless/textless.dart';

class Dialogs {

   static showOnlyLoader(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: white.withOpacity(0.3),
      context: context,
      builder: (context) {
        return SpinKitDoubleBounce(
          size: 60,
          color: primary,
        );
      },
    );
  }

 static showLoader(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
              elevation: 0,
              backgroundColor: transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
          child: Container(
          decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      )
                  ),
                  margin: EdgeInsets.only(right: 80, left: 80),
                  height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
      SpinKitDoubleBounce(
        size: 50,
        color: primary,
      ),
      SizedBox(
        height: 10,
      ),
      loading.h4,
        ],
      ),
    ),
    );
      },
    );
  }

      /// ----------------------------------------------------------
      /// INFO DIALOG   
      /// ----------------------------------------------------------
      /// Dialog to show any info msg, either success or error
  static infoDiallog(BuildContext context, { String? title, discription, image, okBtnText, cancelBtnText,Function()? onCancelClick, Function()? onOkClick,}){
    return showAnimatedDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        title: Text(title ?? "",),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(discription ?? "",)),
           image != null ? Image.asset(image, height: MediaQuery.of(context).size.height*0.2,) : Container(),
            SizedBox(height: 10,),
           cancelBtnText !=null ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButtonWidget(
              title: cancelBtnText,
              onPressed: onCancelClick ?? () {
              Navigator.of(context).pop();
            },
            ),
            SizedBox(width: 10,),
            FilledButtonWidget(
              title: okBtnText ?? "Ok",
              onPressed: onOkClick ?? () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
        :
        FilledButtonWidget(
              title: okBtnText ?? "Ok",
              onPressed: onOkClick ?? () {
                Navigator.of(context).pop();
              },
            ),
        ],),
      ),
    );
  },
  animationType: DialogTransitionType.scale,
  curve: Curves.fastOutSlowIn,
  duration: Duration(seconds: 1),
);
  }

      /// ----------------------------------------------------------
      /// NO INTERNET DIALOG   
      /// ----------------------------------------------------------
      /// Dialog to show case of no internet
  static noInternetDialog(BuildContext context){
    return showAnimatedDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        title: Text(noInternet),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(noInternetDis)),
           Image.asset(noInternetImg, height: MediaQuery.of(context).size.height*0.2,),
        ],),
      ),
    );
  },
  animationType: DialogTransitionType.scale,
  curve: Curves.fastOutSlowIn,
  duration: Duration(seconds: 1),
);
  }

  static hideDialog(BuildContext context){
    Navigator.pop(context);
  }
}