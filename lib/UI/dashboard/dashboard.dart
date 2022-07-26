import 'package:appentus_project/apis/models/photo_gallery_model.dart';
import 'package:appentus_project/apis/providers/dashboard_provider.dart';
import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/widgets/noDataFound.dart';
import 'package:appentus_project/widgets/shimmer_list_withImg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:textless/textless.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({ Key? key }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  late DashBoardProvider _dashBoardProvider;

  @override
  void initState() {
    super.initState();
    _dashBoardProvider = Provider.of<DashBoardProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_dashBoardProvider.imageListResponse == null || _dashBoardProvider.imageListResponse!.photos == null || _dashBoardProvider.imageListResponse!.photos!.isEmpty) {
        _dashBoardProvider.photoListApiCall(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Consumer<DashBoardProvider>(
        builder: (context, dashBoardProvider, child) {
          return !dashBoardProvider.loadingData
        ? dashBoardProvider.error == "" &&
                dashBoardProvider.imageListResponse != null &&
                dashBoardProvider.imageListResponse!.photos != null &&
                dashBoardProvider.imageListResponse!.photos!.isNotEmpty
            ? photosList(dashBoardProvider)
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: NoDataFound(
                    img: dashBoardProvider.error == ""
                        ? empty
                        : noInternetImg,
                    msg: dashBoardProvider.error == ""
                        ? photoNotFoundError
                        : dashBoardProvider.error,
                    btnTxt: dashBoardProvider.error != ""
                        ? retry
                        : refresh,
                    onPressed: () {
                      dashBoardProvider.photoListApiCall(context);
                    },
                  ),
                ),
              ],
            )
        : ShimmerListWithImg(
            height: height * 0.1,
          );
        },);
  }

Widget photosList(DashBoardProvider dashBoardProvider){
  List<Photos>? photos = dashBoardProvider.imageListResponse!.photos;
  return AnimationLimiter(
                child: RefreshIndicator(
                  onRefresh: _refreshPage,
                  color: primary,
                  child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                  ),
                  itemCount: photos!.length,
                  itemBuilder: (context, index){
                    return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 400),
                          child: makeItem(image: photos[index].downloadUrl, title: photos[index].author));
                  })
                  ),
              );
}

  Widget makeItem({image, title}) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ]
            )
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshPage() async {
      _dashBoardProvider.photoListApiCall(context);
  }
}