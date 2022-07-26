import 'package:appentus_project/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  final String? title;
  final void Function() onPressed;
  const FilledButtonWidget({ Key? key, this.title, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                        child: Text(title!, style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(
                          color: white,
                          fontWeight: FontWeight.w500,
                        )),
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                            primary: primary
                        ),
                      );
  }
}