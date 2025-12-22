import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class EditTaskProvider extends ChangeNotifier {
  bool isEditing = false;
  String ? isUpdating;

  Future<NetworkResponse> editTask({
    required String id,
    required String status,
  }) async {
    isEditing = true;
    isUpdating = status;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        Url.updateUrl(id, status),
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
      isEditing = false;
      isUpdating = null;
      notifyListeners();
    }
  }
}
