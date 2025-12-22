import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class ProgressTaskProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<TaskModel> progressTasks = [];

  Future<void> getProgressTasks() async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        Url.progressTaskUrl,
      );
      if (response.isSuccess) {
        errorMessage = null;
        progressTasks.clear();
        List<dynamic> list = response.body["data"];
        for (var t in list) {
          progressTasks.add(TaskModel.fromJson(t));
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
