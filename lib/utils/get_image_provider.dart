import 'dart:convert';
import 'dart:io';
import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/utils/comman.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:textless/textless.dart';


class GetImage with ChangeNotifier{

  File? _pickedImageFile;
  File? imageFile;
  String? base64Image;
  final ImagePicker _picker = ImagePicker();
  

      // select image option bottom sheet
  void gallerybottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Comman.removeFocus(context);
                    Navigator.of(context).pop();
                    getImage(ImageSource.gallery, ctx);
                  },
                  leading: Icon(Icons.photo_album),
                  title: gallery.h3
                ),
                ListTile(
                  onTap: () {
                    Comman.removeFocus(context);
                    Navigator.of(context).pop();
                    getImage(ImageSource.camera, ctx);
                  },
                  leading: Icon(Icons.camera),
                  title: camera.h3,
                ),
                ListTile(
                  onTap: () => Navigator.of(context).pop(),
                  leading: Icon(Icons.close),
                  title: close.h3,
                )
              ],
            ),
          );
        });
  }

      void getImage(ImageSource source, BuildContext context) async {
        bool? status = await checkAndRequestCameraPermissions(source == ImageSource.gallery ? "gal" : "cam", context);
        if ( status != null && status) {
          try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            imageQuality: 20,);
            _pickedImageFile = File(pickedFile!.path);
            notifyListeners();
          await cropImage(context);
        } catch (e) {
            // print("Error while picking image $e");
            notifyListeners();
        }
        }
  }

  void removeImage(int imageNo){
    imageFile = null;
    base64Image = null;
  }

      Future<Null> cropImage(BuildContext context) async {
    try {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedImageFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
              androidUiSettings: AndroidUiSettings(
              toolbarTitle: cropImg,
              toolbarColor: primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
              iosUiSettings: IOSUiSettings(
            title: cropImg,
          ),
        );
    if (croppedFile != null) {
          imageFile = File(croppedFile.path);
      base64Image = base64Encode(imageFile!.readAsBytesSync());
      notifyListeners();
    }
    } 
    catch (e) {
      // print("Crash error ${e.toString()}");
    notifyListeners();
    }
    notifyListeners();
  }

  Future<bool?> checkAndRequestCameraPermissions(String source, BuildContext context) async {
    Permission permission = source == "gal" ? Permission.photos : Permission.camera;
    PermissionStatus permissionStatus = await permission.request();
    // print(permissionStatus);
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await permission.request();
        if (permissionStatus == PermissionStatus.denied) {
          Dialogs.infoDiallog(
            context,
            title: source == "gal" ? photosPermission : cameraPermission,
            discription: source == "gal" ? photosPer : cameraPer,
            okBtnText: ok,
            onOkClick: () {
              Navigator.of(context).pop();
              permission.request();
            },
          );
        return permission.status.isGranted;
      }
      if (permissionStatus == PermissionStatus.permanentlyDenied) {
        Dialogs.infoDiallog(
            context,
            title: source == "gal" ? photosPermission : cameraPermission,
            discription: source == "gal" ? photosPer : cameraPer,
            okBtnText: cancel,
            cancelBtnText: openSettings,
            onOkClick: () {
              Navigator.of(context).pop();
            },
            onCancelClick: (){
              Navigator.pop(context);
            openAppSettings();
        }
          );
        return false;
      } else{
        return true;
      }
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      if (source != "gal") {
        Dialogs.infoDiallog(
          context,
          title: source == "gal" ? photosPermission : cameraPermission,
          discription: source == "gal" ? photosPer : cameraPer,
          okBtnText: cancel,
          cancelBtnText: openSettings,
          onOkClick: () {
            Navigator.of(context).pop();
          },
            onCancelClick: (){
              Navigator.pop(context);
              openAppSettings();
            }
        );
        
      }
      if (source == "gal") {
          Dialogs.infoDiallog(
            context,
            title: source == "gal" ? photosPermission : cameraPermission,
            discription: source == "gal" ? photosPer : cameraPer,
            okBtnText: cancel,
            cancelBtnText: openSettings,
            onOkClick: () {
              Navigator.of(context).pop();
            },
              onCancelClick: (){
                Navigator.pop(context);
                openAppSettings();
              }
          );
        
      }
      return false;
    } else{
      return true;
      }
  }

}