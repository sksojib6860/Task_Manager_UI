import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/otp_pin_verification_provider.dart';
import 'package:task_managment_app/ui/screens/reset_password_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';

class ForgetPasswordOtpVerificationScreen extends StatefulWidget {
  const ForgetPasswordOtpVerificationScreen({super.key});

  static String name = "Forget-password-otp-verification-screen";

  @override
  State<ForgetPasswordOtpVerificationScreen> createState() =>
      _ForgetPasswordOtpVerificationScreen();
}

class _ForgetPasswordOtpVerificationScreen
    extends State<ForgetPasswordOtpVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments;
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
                    "PIN Verification",
                    style: TextTheme.of(context).bodyLarge,
                  ),

                  RichText(
                    text: TextSpan(
                      text: "A 6 digit pin code will sent to the email ",
                      children: [
                        TextSpan(
                          text: "$email",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      style: TextTheme.of(
                        context,
                      ).bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ),
                  PinCodeTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter pin to continue";
                      }
                      if (value.length < 6) {
                        return "input 6 digit to continue";
                      }
                      return null;
                    },
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    appContext: context,
                  ),
                  SizedBox(height: 5),
                  Consumer<OtpPinVerificationProvider>(
                    builder: (context, provider, child) {
                      return Visibility(
                        visible: provider.isVerifying == false,
                        replacement: CenteredCircularProgrress(),
                        child: FilledButton(
                          onPressed: () {
                            _onTapSubmitVerifyButton(email);
                          },
                          child: Text("Verify"),
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

  Future<void> _onTapSubmitVerifyButton(email) async {
    if (_formKey.currentState!.validate()) {
      NetworkResponse response = await context
          .read<OtpPinVerificationProvider>()
          .sendOTP(email: email, code: _pinController.text);

      if (response.isSuccess) {
        if (mounted) {
          snackbarMessgae(context, "Email Verification success");
          Navigator.pushNamed(
            context,
            ResetPasswordScreen.name,
            arguments: {"email": email, "pin": _pinController.text},
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
