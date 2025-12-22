import 'package:flutter/cupertino.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class UpdateProfileProvider extends ChangeNotifier {
  bool isUpdating = false;

  Future<NetworkResponse> updateProfile({
    required Map<String, dynamic> requestBody,
  }) async {
    isUpdating = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        Url.updateProfileUrl,
        body: requestBody,
      );
      if (response.isSuccess) {
        return response;
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: response.errorMessage,
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      isUpdating = false;
      notifyListeners();
    }
  }
}
