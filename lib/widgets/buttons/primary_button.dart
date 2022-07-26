import 'package:appentus_project/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:textless/textless.dart';

class PrimaryButton extends StatelessWidget {
  final String btnTxt;
  final Color? btnTxtColor;
  final double? width;
  final double? btnHeight;
  final double? radius;
  final Color? color;
  final Color? shadowColor;
  final void Function() onPressed;
  const PrimaryButton({ Key? key, required this.btnTxt, required this.onPressed, this.width, this.btnHeight, this.color, this.shadowColor, this.radius, this.btnTxtColor }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width ?? double.infinity,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius ?? 30.0) ),
        clipBehavior: Clip.antiAlias, 
        child: MaterialButton(
          onPressed: onPressed,
          height: btnHeight ?? height*0.08,
          color: color ?? primary,
          splashColor: transparent,
          child: btnTxt.h4.color(btnTxtColor ?? white),
          shape: Border(
            bottom: BorderSide(
                color: shadowColor ?? orange, width: 4.0
            )
        ),
          ),
      ),
    );
  }
}