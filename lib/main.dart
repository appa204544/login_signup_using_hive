import 'dart:io';
import 'package:appentus_project/Routes/routes.dart';
import 'package:appentus_project/UI/authentication_screen/login_screen.dart';
import 'package:appentus_project/UI/dashboard/bottom_nav_bar.dart';
import 'package:appentus_project/UI/dashboard/dashboard.dart';
import 'package:appentus_project/UI/dashboard/profile_screen.dart';
import 'package:appentus_project/apis/models/user_model.dart';
import 'package:appentus_project/apis/providers/dashboard_provider.dart';
import 'package:appentus_project/apis/providers/user_provider.dart';
import 'package:appentus_project/theme/theme_constant.dart';
import 'package:appentus_project/theme/theme_manager.dart';
import 'package:appentus_project/utils/get_image_provider.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Hive.registerAdapter(UserAddapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLogin = false;
  bool isLoading = true;

  @override
  void initState() {
    isLoggIn();
    super.initState();
  }

  isLoggIn() async {
        var box = await Hive.openBox(isLoggedIn);
        isLogin = box.get(isLoggedIn) ?? false;
        isLoading = false;
        if (mounted) {
          setState(() {});
        }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ThemeManager()),
          ChangeNotifierProvider.value(value: GetImage()),
          ChangeNotifierProvider.value(value: DashBoardProvider()),
          ChangeNotifierProvider.value(value: UserProvider()),
        ],
        child: Consumer<ThemeManager>(builder: (context, themeManager, child) {
          return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  currentFocus.focusedChild!.unfocus();
                }
              },
              child: MaterialApp(
                title: 'Appentus',
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeManager.themeMode,
                routes: customRoutes,
                home: isLoading ? Center(child: CircularProgressIndicator()) : isLogin ? BottomNavBar() : LoginScreen(),
              ));
        }));
  }
}
