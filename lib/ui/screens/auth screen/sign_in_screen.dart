import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/data/models/login_model.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth%20screen/email_verification_screen.dart';
import 'package:task_manager/ui/screens/auth%20screen/sign_up_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/utilities/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widgets.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _signInApiInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidgets(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Email';
                        }
                        if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
                          return 'Enter Valid Email Address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: _showPassword == false,
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showPassword = !_showPassword;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          icon: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: _signInApiInProgress == false,
                      replacement: const CenteredProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapNextButton();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    _buildForgotPasswordAndGotoSignupSection()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordAndGotoSignupSection() {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: _onTapForgotPasswordButton,
            child: const Text(
              'Forgot Password?',
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
              text: "Don't have an account? ",
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: const TextStyle(
                    color: AppColors.themeColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapSignUpButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _singIn();
    }
  }

  Future<void> _singIn() async {
    _signInApiInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestData = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    final NetworkResponse networkResponse =
        await NetworkCaller.postRequest(Urls.login, body: requestData);

    _signInApiInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (networkResponse.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(networkResponse.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackBarMassage(
          context,
          networkResponse.errorMassage ??
              'Email or Password Wrong.Please Try Again',
        );
      }
    }
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailVerificationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
