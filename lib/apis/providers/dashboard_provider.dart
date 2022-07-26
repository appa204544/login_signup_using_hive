import 'package:appentus_project/apis/api_handler.dart';
import 'package:appentus_project/apis/models/photo_gallery_model.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {
  ApiHandler apiHandler = ApiHandler();
  bool loadingData = false;
  String error = "";
  PhotoGalleryModel? imageListResponse;
  int currentIndex = 0;

  /// ----------------------------------------------------------
  /// Getting photos list
  void photoListApiCall(BuildContext context) async {
    loadingData = true;
    error = "";
    notifyListeners();
    try {
      PhotoGalleryModel? photoListData = await
      apiHandler.photoListApi();
      if (photoListData!.status == true) {
        loadingData = false;
        imageListResponse = photoListData;
        notifyListeners();
      } 
      else {
        loadingData = false;
        error = photoListData.message!;
        notifyListeners();
      }
    }
    catch (err) {
        loadingData = false;
        error = somethingError;
        notifyListeners();
    }
  }

  updateIndex(int index){
    currentIndex = index;
  }
}