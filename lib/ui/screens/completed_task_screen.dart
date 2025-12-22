import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/providers/completed_task_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<CompletedTaskProvider>().getCompletedTasks();
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
              context.read<CompletedTaskProvider>().getCompletedTasks();
              context.read<TaskCountProvider>().getTaskCounts();
            },
            child: Visibility(
              visible:
                  context.watch<CompletedTaskProvider>().isLoading == false,
              replacement: CenteredCircularProgrress(),
              child: Consumer<CompletedTaskProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CenteredCircularProgrress();
                  } else if (provider.completedTasks.isEmpty) {
                    return Center(child: Text("No Task found"));
                  } else {
                    return ListView.builder(
                      itemCount: provider.completedTasks.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        TaskModel task = provider.completedTasks[index];
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
      ),
    );
  }
}
