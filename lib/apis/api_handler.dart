import 'dart:io';
import 'package:appentus_project/apis/models/photo_gallery_model.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiHandler {
  Dio? _dio;

  Map<String, dynamic> _serverErrorData = {
    "status" : false,
    "message" : serverError,
  };

    Map<String, dynamic> _internetErrorData = {
    "status" : false,
    "message" : noInternetDis,
  };

  String deviceId = '';
  String deviceType = '';
  String deviceUniqueId = '';

  ApiHandler() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl, receiveTimeout: 300000, connectTimeout: 300000);
    _dio = Dio(options);
    _dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }


  /// ----------------------------------------------------------
  /// Getting DEVICE INFO

  static Future<List<String>> getDeviceDetails() async {
    String? deviceId;
    String? deviceType;
    String? deviceUniqueId;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceType = "ANDROID";
        deviceUniqueId = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceType = "IOS";
        deviceUniqueId = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [deviceId!, deviceType!, deviceUniqueId!];
  }


  /// ----------------------------------------------------------
  /// GET PHOTOS LIST API
  /// ----------------------------------------------------------
  /// get all photos

  Future<PhotoGalleryModel?> photoListApi() async {
    try {
      Response res = await _dio!.get(
        photoApiEndPoint,
      );
      if (res.statusCode == 200) {
        PhotoGalleryModel photoGalleryModel = PhotoGalleryModel.fromJson(
          {
            "status": true,
            "message": "Photos Found",
            "photos" : res.data
          });
        return photoGalleryModel;
      }
      else {
        PhotoGalleryModel photoGalleryModel = PhotoGalleryModel.fromJson(_serverErrorData);
        return photoGalleryModel;
      }
    } on SocketException {
        PhotoGalleryModel photoGalleryModel = PhotoGalleryModel.fromJson(_internetErrorData);
        return photoGalleryModel;
    } catch (error) {
        PhotoGalleryModel photoGalleryModel = PhotoGalleryModel.fromJson(_serverErrorData);
        return photoGalleryModel;
    }
  }
  
}
