import 'package:appentus_project/apis/providers/user_provider.dart';
import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/utils/comman.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/widgets/buttons/primary_button.dart';
import 'package:appentus_project/widgets/profile_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:textless/textless.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  double height = 0;
  double width = 0;

  late UserProvider _userProvider;

  @override
  void initState() {
  _userProvider = Provider.of<UserProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_userProvider.userDetails.name == "" || _userProvider.fileImg == null) {
        _userProvider.getMyDetails();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return userProvider.userDetails.name != ""
            ?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height * 0.15),
                              border: Border.all(
                                color: primary,
                                width: 3,
                              )
                            ),
              child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(height * 0.18)),
                      child: Container(
                              height: height * 0.15,
                              width: height * 0.15,
                              child: userProvider.fileImg == null ? 
                                  SpinKitDoubleBounce(
                                    size: 60,
                                    color: primary,
                                  )
                                  : Image.file(userProvider.fileImg!, fit: BoxFit.cover,),
                        ),
        
                    ),
                ),
              Comman.sizeBoxheight(height * 0.06),
                detailWidget(userProvider.userDetails.name, Icons.person_outline_rounded),
              Comman.sizeBoxheight(height * 0.02),
                detailWidget(userProvider.userDetails.email, Icons.email_outlined),
              Comman.sizeBoxheight(height * 0.02),
                detailWidget(userProvider.userDetails.phone, Icons.phone_outlined),
              Comman.sizeBoxheight(height * 0.06),
                PrimaryButton(
                  btnTxt: logout, 
                  onPressed: (){
                  Provider.of<UserProvider>(context, listen: false).logout(context);
                })
              ],
            )
            :
        SpinKitChasingDots(
          size: 60,
          color: primary,
        );
          }
        );
  }

  Widget detailWidget(String title, IconData icon){
    return Container(
      height: height * 0.07,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width*0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.02),
        color: lightGrey
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          title.h4,
          Container(width: width*0.1,)
        ],
      ),
    );
  }
}