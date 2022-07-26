import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/utils/validations.dart';
import 'package:appentus_project/widgets/textfields/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  const NameTextField({ Key? key, this.controller, this.autovalidateMode, this.validator, this.hintText, this.prefixIcon }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return TextFieldWidget(
                labelText: hintText ?? name,
                hintText: enterName,
                controller: controller,
                maxLength: 50,
                prefixIcon: IconButton(onPressed: null,
                  icon: Icon(Icons.person_outline_rounded, size: height*0.03),splashRadius: 1,),
                autovalidateMode: autovalidateMode,
                inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                   new LengthLimitingTextInputFormatter(100),
                ],
                validator: validator ?? (value){
                  return Validations.nameValidator(value!.trim());
                }
                );
  }
}