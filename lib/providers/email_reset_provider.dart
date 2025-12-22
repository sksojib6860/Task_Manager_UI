import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class EmailResetProvider extends ChangeNotifier {
  bool isReseting = false;

  Future<NetworkResponse> resetEmail({
    required String email,
  }) async {
    isReseting = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        Url.recoveryEmailUrl(email),
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
      isReseting = false;
      notifyListeners();
    }
  }
}
