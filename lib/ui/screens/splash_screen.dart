import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/providers/user_provider.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String name = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final provider = context.read<UserProvider>();
    bool isLoggedIn = await provider.isUserLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      await provider.getUserData();

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, MainLayoutScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, SignInScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: Image.asset(width: 150, AssetsPath.logo)),
      ),
    );
  }
}
