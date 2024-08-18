import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/controller/pin_verification_controller.dart';
import 'package:task_manager/ui/screens/auth%20screen/sign_in_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widgets.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidgets(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digits verification pin has been sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildPinCodeTextField(context),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<PinVerificationController>(
                      builder: (pinVerificationController) {
                    return Visibility(
                      visible:
                          pinVerificationController.pinVerificationInProgress ==
                              false,
                      replacement: const CenteredProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          bool success =
                              await pinVerificationController.pinVerification(
                            widget.email,
                            _pinTEController.text.trim(),
                          );
                          if (success) {
                            successSnackbarMassage('Pin Verification',
                                'Pin Verification Successfull');
                          } else {
                            failedSnackbarMassage('Pin Verification',
                                'Pin Verification Failed!! Try Again');
                          }
                        },
                        child: const Text('Verify'),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 36,
                  ),
                  _buildBackToSignInSection()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      controller: _pinTEController,
      appContext: context,
    );
  }

  Widget _buildBackToSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
          text: "Have account? ",
          children: [
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                color: AppColors.themeColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    Get.offUntil(
        GetPageRoute(page: () => const SignInScreen()), (route) => false);
  }
}
