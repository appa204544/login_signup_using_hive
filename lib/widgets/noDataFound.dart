import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final double? size;
  final String? msg;  
  final String? img;
  final bool? noImg;
  final String? btnTxt;
  final Function()? onPressed;
  const NoDataFound({Key? key, this.size, this.msg, this.img, this.onPressed, this.btnTxt, this.noImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
        children: [
    noImg ?? true 
    ?
    Image.asset(
      img ?? empty,
      height: size ?? height * 0.4,
    )
    :
    Container(),
    Text(
      msg ?? noRecordError,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline5,
    ),
    SizedBox(height: height*0.01,),
    btnTxt != null ? 
    PrimaryButton(
      btnTxt: btnTxt!,  
      width: width*0.3,
      onPressed: onPressed!) : Container(),
        ],
      );
  }
}
