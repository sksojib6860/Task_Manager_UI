import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class TaskDeleteProvider extends ChangeNotifier {
  bool isDeleting = false;

  Future<NetworkResponse> deleteTask({required String id}) async {
    isDeleting = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        Url.deleteUrl(id),
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
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }
}
