import 'package:flutter/material.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class SignUpProvider extends ChangeNotifier {
  bool isSignInInProgress = false;

  Future<NetworkResponse> signUp({
    required email,
    required firstName,
    required lastname,
    required mobile,
    required password,
  }) async {
    isSignInInProgress = true;
    notifyListeners();
    try {
      Map<String, dynamic> requestBody = {
        "email": email,
        "firstName": firstName,
        "lastName": lastname,
        "mobile": mobile,
        "password": password,
      };
      NetworkResponse response = await NetworkCaller.postRequest(
        Url.registerUrl,
        body: requestBody,
      );

      if (response.isSuccess) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      isSignInInProgress = false;
      notifyListeners();
    }
  }
}
