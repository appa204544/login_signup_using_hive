import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  //pref- value
  static String authToken = "auth_token";
  static String loginToken = "token";
  static String email = "email";
  static String userId = "userId";
  static String notificationToken = "notificationToken";
  static String password = "password";
  static String authorization = "Authorization";
  static String isLoggedIn = "isLoggedIn";
  static String showIntro = "showIntro";
  static String userData = "userData";
  static String internetStatus = "internetStatus";
  static String subsPurchased = "subsPurchased";
  static String twoFactorStatus = "twoFactorStatus";
  static String notificationStatus = "notificationStatus";
  static String showCalPermissionDialog = "showCalPermissionDialog";
  static String showPhotoPemissionDialog = "showPhotoPemissionDialog";
  static String showCameraPemissionDialog = "showCameraPemissionDialog";
  static String calendarID = "calendarID";

  static SpUtil? _instance;
  static Future<SpUtil?> get instance async {
    return await getInstance();
  }

  static SharedPreferences? _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil?> getInstance() async {
    if (_instance == null) {
      _instance = new SpUtil._();
    }
    if (_spf == null) {
      await _instance!._init();
    }
    return _instance;
  }

  // check the _spf have contain value or not
  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf!.setString(key, value);
  }

  bool? getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getBool(key)!;
  }

  Future<bool>? putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getInt(key)!;
  }

  Future<bool>? putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getDouble(key)!;
  }

  Future<bool>? putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf!.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf!.getStringList(key)!;
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf!.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  Future<bool>? remove(String key) {
    if (_beforeCheck()) return null;
    return _spf!.remove(key);
  }

  Future<bool>? clear() {
    if (_beforeCheck()) return null;
    return _spf!.clear();
  }
}