import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/email_reset_provider.dart';
import 'package:task_managment_app/ui/screens/forget_password_otp_verification_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';

class ForgetPasswordEmail extends StatefulWidget {
  const ForgetPasswordEmail({super.key});

  static String name = "forget-password-email";

  @override
  State<ForgetPasswordEmail> createState() => _ForgetPasswordEmailState();
}

class _ForgetPasswordEmailState extends State<ForgetPasswordEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
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
                    "Your Email Address",
                    style: TextTheme.of(context).bodyLarge,
                  ),
                  Text(
                    "A 6 digit pin code will sent to Your Email Address",
                    style: TextTheme.of(
                      context,
                    ).bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      if (!value.contains(".com") || !value.contains("@")) {
                        return "Enter valid Email";
                      }
                      return null;
                    },
                    controller: _emailController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                  ),
                  SizedBox(height: 5),
                  Consumer<EmailResetProvider>(
                    builder: (context, provider, child) {
                      return Visibility(
                        visible: provider.isReseting == false,
                        replacement: CenteredCircularProgrress(),
                        child: FilledButton(
                          onPressed: _onTapSubmitEmailButton,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 25,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Column(
                      spacing: 5,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black87),
                            text: "have an account? ",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignIn,
                                text: "Sign in",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSubmitEmailButton() async {
    if (_formKey.currentState!.validate()) {
      NetworkResponse response = await context
          .read<EmailResetProvider>()
          .resetEmail(email: _emailController.text.trim());

      if (response.isSuccess) {
        if (mounted) {
          snackbarMessgae(context, response.body["data"]);
          Navigator.pushNamed(
            context,
            ForgetPasswordOtpVerificationScreen.name,
            arguments: _emailController.text,
          );
        }
      } else {
        if (mounted) {
          snackbarMessgae(context, response.errorMessage.toString());
        }
      }
    }
  }

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }
}
