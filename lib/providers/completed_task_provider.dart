import 'package:flutter/widgets.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class CompletedTaskProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<TaskModel> completedTasks = [];

  Future<void> getCompletedTasks() async {
    isLoading = true;
    notifyListeners();
    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        Url.completeTaskUrl,
      );

      if (response.isSuccess) {
        errorMessage = null;
        completedTasks.clear();
        List<dynamic> list = response.body["data"];
        for (var t in list) {
          completedTasks.add(TaskModel.fromJson(t));
        }
      } else {
        errorMessage = response.body;
      }
    } catch (e) {
      debugPrint("completed Tasks loadin failed $e");
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
