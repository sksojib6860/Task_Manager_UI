import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managment_app/data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  static String? accessToken;
  UserModel? user;
  final String _userKey = "user";
  final String _tokenKey = "token";

  Future<void> saveUserData(String token, UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(userModel.toJson()));
    user = userModel;
    accessToken = token;

    notifyListeners();
  }

  Future<void> updateUserData(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userModel.toJson()));

    user = userModel;
    notifyListeners();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    String? userJson = prefs.getString(_userKey);

    if (token != null && userJson != null) {
      accessToken = token;
      user = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    user = null;
    accessToken = null;
  }
}
