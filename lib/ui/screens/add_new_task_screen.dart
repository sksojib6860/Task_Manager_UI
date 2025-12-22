import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/add_task_provider.dart';
import 'package:task_managment_app/providers/canceled_task_provider.dart';
import 'package:task_managment_app/providers/completed_task_provider.dart';
import 'package:task_managment_app/providers/new_task_provider.dart';
import 'package:task_managment_app/providers/progress_task_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
import 'package:task_managment_app/ui/widgets/app_bar_widget.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static String name = "add-new-task-screen";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreen();
}

class _AddNewTaskScreen extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  bool isAddTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: ScreenBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add New Task",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _titleTEController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter title";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Subject",
                        prefixIcon: Icon(Icons.note_add_outlined),
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 5,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter description";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Description",
                        prefixIcon: Icon(Icons.document_scanner_outlined),
                      ),
                    ),
                    SizedBox(height: 5),
                    Consumer<AddTaskProvider>(
                      builder: (context, provider, child) {
                        return Visibility(
                          visible: provider.isAdding == false,
                          replacement: CenteredCircularProgrress(),
                          child: FilledButton(
                            onPressed: _onTapAddNewTask,
                            child: Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 25,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapAddNewTask() async {
    if (_formKey.currentState!.validate()) {
      if (mounted) {
        NetworkResponse response = await context
            .read<AddTaskProvider>()
            .addTask(
              title: _titleTEController.text.trim(),
              description: _descriptionTEController.text.trim(),
            );
        if (response.isSuccess) {
          _clearForm();
          if (mounted) {
            snackbarMessgae(context, "New task added successfully");
          }
          _refresh();
        } else {
          if (mounted) {
            snackbarMessgae(context, response.errorMessage.toString());
          }
        }
      }
    }
  }

  _clearForm() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }




  void _refresh() {
    context.read<NewTaskProvider>().getNewTasks();
    context.read<TaskCountProvider>().getTaskCounts();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }



}
