import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/canceled_task_screen.dart';
import 'package:task_managment_app/ui/screens/completed_task_screen.dart';
import 'package:task_managment_app/ui/screens/new_task_screen.dart';
import 'package:task_managment_app/ui/screens/progressing_task_screen.dart';
import 'package:task_managment_app/ui/widgets/app_bar_widget.dart';
import 'package:task_managment_app/ui/widgets/task_counts_widget.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  static const String name = "main-layout-screen";

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressingTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = colorScheme.primary;

    return Scaffold(
      appBar: const AppbarWidget(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            TaskCountsWidget(),
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        backgroundColor: colorScheme.surface,
        indicatorColor: primaryColor.withOpacity(0.15),
        elevation: 8,
        height: 65,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          _navItem(
            Icons.new_label_outlined,
            Icons.new_label,
            "New",
            primaryColor,
            textTheme,
          ),
          _navItem(
            Icons.task_alt_outlined,
            Icons.task_alt,
            "Completed",
            primaryColor,
            textTheme,
          ),
          _navItem(
            Icons.cancel_outlined,
            Icons.cancel,
            "Canceled",
            primaryColor,
            textTheme,
          ),
          _navItem(
            Icons.history_toggle_off_outlined,
            Icons.history_toggle_off,
            "Progress",
            primaryColor,
            textTheme,
          ),
        ],
      ),
    );
  }

  NavigationDestination _navItem(
    IconData icon,
    IconData activeIcon,
    String label,
    Color activeColor,
    TextTheme textTheme,
  ) {
    return NavigationDestination(
      icon: Icon(icon, color: Colors.black54),
      selectedIcon: Icon(activeIcon, color: activeColor),
      label: label,
    );
  }
}
