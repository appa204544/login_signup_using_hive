import 'package:appentus_project/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  const OutlinedButtonWidget({Key? key, this.title,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2.0,
          color: primary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      onPressed: onPressed,
      child: Text(title?? "",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: primary,
                fontWeight: FontWeight.w500,
              )),
    );
  }
}
