import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/providers/progress_task_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';

class ProgressingTaskScreen extends StatefulWidget {
  const ProgressingTaskScreen({super.key});

  @override
  State<ProgressingTaskScreen> createState() => _ProgressingTaskScreenState();
}

class _ProgressingTaskScreenState extends State<ProgressingTaskScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<ProgressTaskProvider>().getProgressTasks();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<ProgressTaskProvider>().getProgressTasks();
              context.read<TaskCountProvider>().getTaskCounts();
            },
            child: Consumer<ProgressTaskProvider>(
              builder: (context, ProgressTaskProvider provider, child) {
                if (provider.isLoading) {
                  return CenteredCircularProgrress();
                } else if (provider.errorMessage != null) {
                  return Center(child: Text(provider.errorMessage.toString()));
                } else if (provider.progressTasks.isEmpty) {
                  return Center(child: Text("No Task found"));
                } else {
                  return ListView.builder(
                    itemCount: provider.progressTasks.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      TaskModel task = provider.progressTasks[index];
                      return TaskCard(
                        task: task,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
