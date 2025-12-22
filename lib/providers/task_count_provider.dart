import 'package:flutter/material.dart';
import 'package:task_managment_app/data/models/task_count_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class TaskCountProvider extends ChangeNotifier {
  List<dynamic> taskCounts = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getTaskCounts() async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        Url.taskCountUrl,
      );
      if (response.isSuccess) {
        errorMessage = null;
        taskCounts.clear();

        List<dynamic> list = response.body["data"];
        for (var c in list) {
          taskCounts.add(TaskCountModel.fromJson(c));
        }
      } else {
        errorMessage = response.body;
      }
    } catch (e) {
      errorMessage = e.toString();
      debugPrint("task counts loading failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
