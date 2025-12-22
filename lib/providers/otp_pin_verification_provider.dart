import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class OtpPinVerificationProvider extends ChangeNotifier {
  bool isVerifying = false;

  Future<NetworkResponse> sendOTP({
    required String email,
    required String code,
  }) async {
    isVerifying = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        Url.verifyOtpUrl(email, code),
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
      isVerifying = false;
      notifyListeners();
    }
  }
}
