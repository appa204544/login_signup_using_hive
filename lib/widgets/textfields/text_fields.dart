import 'package:appentus_project/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
class TextFieldWidget extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? focusedBorder;
  final bool? filled;
  final AutovalidateMode? autovalidateMode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double? elevation;
  final bool? readOnly;
  final Color? readOnlyColor;
  final TextStyle? hintStyle;
  final String? counterText;
  final TextAlignVertical? textAlignVertical;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  const TextFieldWidget({ Key? key, this.hintText, this.controller, this.obscureText, this.validator, this.suffixIcon, this.textInputAction, this.keyboardType, this.maxLength, this.counterText, this.onTap, this.maxLines, this.minLines, this.prefixIcon, this.filled, this.elevation,this.focusedBorder, this.inputFormatters,this.hintStyle, this.readOnly, this.autovalidateMode, this.readOnlyColor, this.onFieldSubmitted, this.textAlignVertical, this.labelText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: black,
      obscureText: obscureText ?? false,
      validator: validator,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      textAlignVertical: textAlignVertical,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
      readOnly: readOnly ?? false,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLength: maxLength ?? 200,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      inputFormatters: inputFormatters ?? [],
      style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    counterText: counterText ?? '',
                  hintText: hintText,
                  labelText: labelText,
                  labelStyle: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.normal),
                  errorMaxLines: 2,
                  contentPadding: const EdgeInsets.all(15),
                  // contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  hintStyle: hintStyle ?? Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.normal),
                  fillColor: readOnlyColor,
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  focusColor: black,
                    errorStyle: Theme.of(context).textTheme.headline6!.copyWith(color:red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: lightGrey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: lightGrey,
                    ),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: lightGrey,
                      width: 3,
                    ),
                  ),

          ),
                );
  }
}