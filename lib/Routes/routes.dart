import 'package:appentus_project/UI/authentication_screen/login_screen.dart';
import 'package:appentus_project/UI/authentication_screen/sign_up_screen.dart';
import 'package:appentus_project/UI/dashboard/bottom_nav_bar.dart';
import 'package:appentus_project/UI/dashboard/dashboard.dart';
import 'package:appentus_project/UI/dashboard/profile_screen.dart';
import 'package:flutter/material.dart';


var customRoutes = <String, WidgetBuilder>{

  '/loginScreen': (context) => LoginScreen(),
  '/signUpScreen': (context) => SignUpScreen(),
  '/dashboard': (context) => DashBoard(),
  '/profileScreen': (context) => ProfileScreen(),
  '/bottomNavBar': (context) => BottomNavBar(),
  
};