import 'package:flutter/material.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class CanceledTaskProvider extends ChangeNotifier {
  bool isLoading = false;
  List<TaskModel> canceledTasks = [];
  String? errorMessage;

  Future<void> getCanceledTask() async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        Url.cancelTaskUrl,
      );
      if (response.isSuccess) {
        errorMessage = null;
        canceledTasks.clear();
        List<dynamic> list = response.body["data"];
        for (var t in list) {
          canceledTasks.add(TaskModel.fromJson(t));
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
