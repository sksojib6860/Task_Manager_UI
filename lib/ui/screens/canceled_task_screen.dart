import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/providers/canceled_task_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';


class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<CanceledTaskProvider>().getCanceledTask();
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
              context.read<CanceledTaskProvider>().getCanceledTask();
              context.read<TaskCountProvider>().getTaskCounts();
            },
            child: Consumer<CanceledTaskProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return CenteredCircularProgrress();
                } else if (provider.canceledTasks.isEmpty) {
                  return Center(child: Text("Task not found"));
                } else if (provider.errorMessage != null) {
                  return Center(child: Text(provider.errorMessage.toString()));
                } else {
                  return ListView.builder(
                    itemCount: provider.canceledTasks.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      TaskModel task = provider.canceledTasks[index];
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
