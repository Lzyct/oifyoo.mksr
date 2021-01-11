import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  String kIsLogin = "isLogin";
  String kToken = "token";
  String kText = "text";
  String kColor = "color";
  String kIcon = "icon";
  String kUser = "user";
  SharedPreferences preferences;

  PrefManager(this.preferences);

  //for Bloc.Bloc.login
  Future<bool> setIsLogin(bool value) async =>
      await preferences.setBool(kIsLogin, value);

  bool getIsLogin() => preferences.getBool(kIsLogin) ?? false;

  Future<bool> setToken(String value) async =>
      await preferences.setString(kToken, value);

  String getToken() => preferences.getString(kToken) ?? null;

  Future<bool> setUser(String value) async =>
      await preferences.setString(kUser, value);

  String getUser() => preferences.getString(kUser) ?? null;

  Future<bool> setTexts(String value) async =>
      await preferences.setString(kText, value);

  String getText() => preferences.getString(kText) ?? null;

  Future<bool> setColors(String value) async =>
      await preferences.setString(kColor, value);

  String getColor() => preferences.getString(kColor) ?? null;

  Future<bool> setIcons(String value) async =>
      await preferences.setString(kIcon, value);

  String getIcon() => preferences.getString(kIcon) ?? null;

  logout() => preferences.clear();
}
