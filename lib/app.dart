import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/providers/add_task_provider.dart';
import 'package:task_managment_app/providers/canceled_task_provider.dart';
import 'package:task_managment_app/providers/completed_task_provider.dart';
import 'package:task_managment_app/providers/edit_task_provider.dart';
import 'package:task_managment_app/providers/email_reset_provider.dart';
import 'package:task_managment_app/providers/new_task_provider.dart';
import 'package:task_managment_app/providers/otp_pin_verification_provider.dart';
import 'package:task_managment_app/providers/progress_task_provider.dart';
import 'package:task_managment_app/providers/reset_password_provider.dart';
import 'package:task_managment_app/providers/sign_in_provider.dart';
import 'package:task_managment_app/providers/sign_up_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
import 'package:task_managment_app/providers/task_delete_provider.dart';
import 'package:task_managment_app/providers/update_profile_provider.dart';
import 'package:task_managment_app/providers/user_provider.dart';
import 'package:task_managment_app/ui/screens/add_new_task_screen.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/forget_password_otp_verification_screen.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/new_task_screen.dart';
import 'package:task_managment_app/ui/screens/reset_password_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/screens/sign_up_screen.dart';
import 'package:task_managment_app/ui/screens/splash_screen.dart';
import 'package:task_managment_app/ui/screens/update_profile_screen.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    final baseColor = Color(0xFF0D78BF);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => NewTaskProvider()),
        ChangeNotifierProvider(create: (_) => TaskCountProvider()),
        ChangeNotifierProvider(create: (_) => CompletedTaskProvider()),
        ChangeNotifierProvider(create: (_) => CanceledTaskProvider()),
        ChangeNotifierProvider(create: (_) => ProgressTaskProvider()),
        ChangeNotifierProvider(create: (_) => AddTaskProvider()),
        ChangeNotifierProvider(create: (_) => TaskDeleteProvider()),
        ChangeNotifierProvider(create: (_) => EditTaskProvider()),
        ChangeNotifierProvider(create: (_) => UpdateProfileProvider()),
        ChangeNotifierProvider(create: (_) => EmailResetProvider()),
        ChangeNotifierProvider(create: (_) => OtpPinVerificationProvider()),
        ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: baseColor,
            secondary: Colors.grey.shade700,
            surface: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
          ),

          appBarTheme: AppBarTheme(
            backgroundColor: baseColor,
            foregroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            elevation: 2,
          ),

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),

          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: baseColor,
              foregroundColor: Colors.white,
              fixedSize: const Size(double.maxFinite, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            bodySmall: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
            titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),


        routes: {
          SplashScreen.name: (_) => const SplashScreen(),
          MainLayoutScreen.name: (_) => const MainLayoutScreen(),
          ForgetPasswordEmail.name: (_) => const ForgetPasswordEmail(),
          SignInScreen.name: (_) => const SignInScreen(),
          ForgetPasswordOtpVerificationScreen.name: (_) =>
              const ForgetPasswordOtpVerificationScreen(),
          ResetPasswordScreen.name: (_) => const ResetPasswordScreen(),
          SignUpScreen.name: (_) => const SignUpScreen(),
          AddNewTaskScreen.name: (_) => const AddNewTaskScreen(),
          NewTaskScreen.name: (_) => const NewTaskScreen(),
          UpdateProfileScreen.name: (_) => const UpdateProfileScreen(),
        },

        initialRoute: SplashScreen.name,
      ),
    );
  }
}
