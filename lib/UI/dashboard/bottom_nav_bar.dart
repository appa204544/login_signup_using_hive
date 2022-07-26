import 'package:appentus_project/UI/dashboard/dashboard.dart';
import 'package:appentus_project/UI/dashboard/profile_screen.dart';
import 'package:appentus_project/apis/providers/dashboard_provider.dart';
import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/theme/theme_manager.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({ Key? key }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        actions: [
          Consumer<ThemeManager>(builder: (context, themeManager, child) {
            return Switch(
                value: themeManager.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeManager.toggleTheme(value);
                });
          })
        ],
      ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: height * 0.07,
          items: <Widget>[
            const Icon(Icons.photo_library_outlined, size: 30, color: white,),
            const Icon(Icons.person_outline_rounded, size: 30, color: white,),
          ],
          color: primary,
          buttonBackgroundColor: primary,
          backgroundColor: transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
          letIndexChange: (index) => true,
        ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: PageView(
            controller: _pageController,
            children: [
              DashBoard(),
              ProfileScreen()
            ],
          )
          // Consumer<DashBoardProvider>(
          //   builder: (context, dashBoardProvider, child) {
          //     return dashBoardProvider.currentIndex == 0
          //     ?
          //      DashBoard()
          //      : ProfileScreen();
          //   }
          // ),
        )
      ),
    );
  }
}