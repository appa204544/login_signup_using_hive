import 'dart:convert';
import 'dart:io';
import 'package:appentus_project/apis/models/user_model.dart';
import 'package:appentus_project/utils/get_image_provider.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {

List<UserModel> _userList = <UserModel>[];
File? fileImg;
UserModel _userDetails = UserModel(name: "", email: "", phone: "", password: "", image: "");
List<UserModel> get userList => _userList;
UserModel get userDetails => _userDetails;


  Future addUser(UserModel user) async {
    var userInfo = await Hive.openBox<UserModel>(myDetails);
    userInfo.put(myDetails, user);
    var userList = await Hive.openBox<UserModel>(users);
    userList.add(user);
    notifyListeners();
  }

  Future getUsers() async {
      final box = await Hive.openBox<UserModel>(users);
      _userList = box.values.toList();
      notifyListeners();
  }

  Future getMyDetails() async {
      final box = await Hive.openBox<UserModel>(myDetails);
      _userDetails = box.get(myDetails)!;
      writeFile(_userDetails.image);
      notifyListeners();
  }

  signUp(BuildContext context,{required String image, required String name, required String email, required String phone, required String password}) async {
    Dialogs.showOnlyLoader(context);
    bool isUserExists = false;
    await getUsers();
    if (userList.isNotEmpty) {
     for (var i = 0; i < userList.length; i++) {
      if (userList[i].email == email) {
        isUserExists = true;
        break;
      }
     }
    }

    if (isUserExists) {
        Future.delayed(Duration(seconds: 2)).then((value) async {
        Dialogs.hideDialog(context);
        Dialogs.infoDiallog(
          context,
          title: oops,
          image: errorImg,
          discription: userAlreadyExist,
          );
        });
    } else{
        await addUser(UserModel(name: name, email: email, phone: phone, password: password, image: image));
        GetImage getImage = Provider.of<GetImage>(context, listen: false);
        getImage.imageFile = null;
        getImage.base64Image = null;
        Future.delayed(Duration(seconds: 2)).then((value) async {
        Dialogs.hideDialog(context);
        var box = await Hive.openBox(isLoggedIn);
        box.put(isLoggedIn, true);
        Dialogs.infoDiallog(
          context,
          title: success,
          image: successImg,
          discription: registerSuccess,
          onOkClick: () => Navigator.pushNamedAndRemoveUntil(context, '/bottomNavBar', (route) => false),
          );
        });
    }
  }

  login(BuildContext context, {required String email, required String password}) async {
    Dialogs.showOnlyLoader(context);
    await getUsers();
    bool isLogin = false;
    bool isPassWordMatch = true;
    for (var i = 0; i < userList.length; i++) {
      if (userList[i].email == email) {
        if (userList[i].password == password) {
        var userInfo = await Hive.openBox<UserModel>(myDetails);
        userInfo.put(myDetails, userList[i]);
        isLogin = true;
        break;
        }
        else{
          isPassWordMatch = false;
          break;
        }
      }
    }
    Future.delayed(Duration(seconds: 2)).then((value) async {
  Dialogs.hideDialog(context);
    if (isLogin) {
        var box = await Hive.openBox(isLoggedIn);
        box.put(isLoggedIn, true);
      Navigator.pushNamedAndRemoveUntil(context, '/bottomNavBar', (route) => false);
    } else if(isPassWordMatch){
        Dialogs.infoDiallog(
          context,
          title: oops,
          image: errorImg,
          discription: userDoesntExist,
          );
    } else{
        Dialogs.infoDiallog(
          context,
          title: oops,
          image: errorImg,
          discription: wrongPassError,
          );
    }
    });
  }

  logout(BuildContext context) async {
    Dialogs.showOnlyLoader(context);
    var box = await Hive.openBox(isLoggedIn);
    box.put(isLoggedIn, false);
    notifyListeners();
    Future.delayed(Duration(seconds: 2)).then((value) {
    fileImg = null;
    _userDetails = UserModel(name: "", email: "", phone: "", password: "", image: "");
    Dialogs.hideDialog(context);
    Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
    });
  }

  void writeFile(String base64Image) async {
    final decodedBytes = base64Decode(base64Image);
    final directory = await getApplicationDocumentsDirectory();
    fileImg = File('${directory.path}/testImage.png');
    fileImg!.writeAsBytesSync(List.from(decodedBytes));

    notifyListeners();
  }

}