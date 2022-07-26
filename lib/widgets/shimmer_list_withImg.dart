import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListWithImg extends StatelessWidget {
  final double? height;

  const ShimmerListWithImg({Key? key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext buildContext, int index) {
          return _LoadingItem(
            height: height,
          );
        });
  }
}

class _LoadingItem extends StatelessWidget {
  final double? height;

  const _LoadingItem({Key? key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.white,
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                                ])),
                      ),
                    ),
                  );
                })),
      ],
    );
  }
}
