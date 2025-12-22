import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/providers/new_task_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
import 'package:task_managment_app/ui/screens/add_new_task_screen.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static String name = "neq-task-screen";

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<NewTaskProvider>().getNewTasks();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddTaskButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.add),
      ),
      body: ScreenBackground(
        child: Center(
          child: Consumer<NewTaskProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return CenteredCircularProgrress();
              } else if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage.toString()));
              } else if (provider.newTasks.isEmpty) {
                return Center(child: Text("Tasks not found"));
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    provider.getNewTasks();
                    context.read<TaskCountProvider>().getTaskCounts();
                  },
                  child: ListView.builder(
                    itemCount: provider.newTasks.length,
                    itemBuilder: (context, index) {
                      TaskModel task = provider.newTasks[index];
                      return TaskCard(
                        task: task,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _onTapAddTaskButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
