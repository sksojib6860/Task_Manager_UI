import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_count_model.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';

class TaskCountsWidget extends StatefulWidget {
  const TaskCountsWidget({super.key});

  @override
  State<TaskCountsWidget> createState() => _TaskCountsWidgetState();
}

class _TaskCountsWidgetState extends State<TaskCountsWidget> {

  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<TaskCountProvider>().getTaskCounts();
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCountProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 70,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(width: 5);
            },
            scrollDirection: Axis.horizontal,
            itemCount: provider.taskCounts.length,
            itemBuilder: (context, index) {
              TaskCountModel taskCount = provider.taskCounts[index];

              return Container(
                width: MediaQuery.of(context).size.width / 4 - 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        provider.isLoading ? "--" : taskCount.sum.toString(),
                        style: TextTheme.of(
                          context,
                        ).bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        taskCount.id,
                        style: TextTheme.of(context).bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
