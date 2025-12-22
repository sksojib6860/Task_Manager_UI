import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managment_app/data/models/user_model.dart';

class provider {
  static const String _userKey = "user";
  static const String _tokenKey = "token";

  static String? accessToken;
  static UserModel? user;

  static Future<void> saveUserData(String token, UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(userModel.toJson()));

    user = userModel;
    accessToken = token;
  }


}