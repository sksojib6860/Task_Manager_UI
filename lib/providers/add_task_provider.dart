import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class AddTaskProvider extends ChangeNotifier {
  bool isAdding = false;

  Future<NetworkResponse> addTask({
    required String title,
    required String description,
  }) async {
    isAdding = true;
    notifyListeners();

    final Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
    };

    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        Url.createTaskUrl,
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
      isAdding = false;
      notifyListeners();
    }
  }
}
