import 'package:flutter/material.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class NewTaskProvider extends ChangeNotifier {
  List<TaskModel> newTasks = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getNewTasks() async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(Url.newTaskUrl);

      if (response.isSuccess) {
        newTasks.clear();
        errorMessage = null;
        final List<dynamic> list = response.body["data"];
        for (var t in list) {
          newTasks.add(TaskModel.fromJson(t));
        }
      }
    } catch (e) {
      errorMessage = e.toString();
      debugPrint("New tasks loading failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
