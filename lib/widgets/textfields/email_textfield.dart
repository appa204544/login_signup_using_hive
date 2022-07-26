import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/utils/validations.dart';
import 'package:appentus_project/widgets/textfields/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final Widget? prefixIcon;
  final AutovalidateMode? autovalidateMode;

  const EmailTextfield({Key? key, this.controller, this.autovalidateMode, this.hintText, this.prefixIcon, this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return TextFieldWidget(
      labelText: hintText ?? email,
      hintText: enterEmail,
      keyboardType: TextInputType.emailAddress,
      readOnly: readOnly ?? false,
      prefixIcon: IconButton(onPressed: null,
       icon: Icon(Icons.mail_outline_outlined, size: height*0.03),splashRadius: 1,),
      autovalidateMode: autovalidateMode,
      textInputAction: TextInputAction.next,
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      validator: (value) {
        return Validations.emailValidator(value!.trim());
      },
      maxLength: 100,
    );
  }
}
