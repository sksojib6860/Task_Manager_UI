import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/sign_up_provider.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/utils/url.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String name = "sign-up-screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSignInInProgress = false;

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool isPasswordShow = true;

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Join with Us",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _emailTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter email";
                        }
                        if (EmailValidator.validate(value!) == false) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _firstNameTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "First name",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter first name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Last name",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter last name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Mobile",
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter mobile";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: isPasswordShow,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordShow = !isPasswordShow;
                            });
                          },
                          icon: Icon(
                            isPasswordShow
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter email";
                        }
                        if (value!.length < 8) {
                          return "password must be at least 8 character";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    Consumer<SignUpProvider>(
                      builder: (context, provider, child) {
                       return Visibility(
                          visible: provider.isSignInInProgress == false,
                          replacement: Center(child: CircularProgressIndicator()),
                          child: FilledButton(
                            onPressed: _onTapSignUpButton,
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
                          GestureDetector(
                            onTap: _onTapForgetPassword,
                            child: Text(
                              "Forgot password ?",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black87),
                              text: "Don't have an account? ",
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignIn,
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
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
      ),
    );
  }

  void _onTapSignUpButton() async {
    if (_formKey.currentState!.validate()) {
      NetworkResponse response = await context.read<SignUpProvider>().signUp(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastname: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
        password: _passwordTEController.text,
      );
      if (response.isSuccess && mounted) {
        snackbarMessgae(context, "Sign up success");
        _clearForm();
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInScreen.name,
          (predicated) => false,
        );
      } else {
        if (mounted) {
          snackbarMessgae(context, response.errorMessage.toString());
        }
      }
    }
  }

  _clearForm() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void _onTapForgetPassword() {
    Navigator.pushNamed(context, ForgetPasswordEmail.name);
  }
}
