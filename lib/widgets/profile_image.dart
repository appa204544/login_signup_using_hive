import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final String? imageUrl;

  const ProfileImage({Key? key,  this.imageUrl}) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
      return Container(
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
                        height: height * 0.18,
                        width: height * 0.18,
                        child: widget.imageUrl != ""
                        ? CachedNetworkImage(
                          imageUrl: widget.imageUrl!,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) => 
                                  CircularProgressIndicator(value: downloadProgress.progress, color: primary,),
                          errorWidget: (context, url, error) => Image.asset(defaultImg,),
                      )
                      :
                      Image.asset(defaultImg,),
                            ),
              ),
      );
  }
}
