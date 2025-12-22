import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool isResting = false;

  Future<NetworkResponse> resetPassword({
    required String email,
    required String password,
    required String otp,
  }) async {
    isResting = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        Url.resetPasswordUrl,
        body: {"email": email, "OTP": otp, "password": password},
      );
      if (response.isSuccess) {
        return response;
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      isResting = false;
      notifyListeners();
    }
  }
}
