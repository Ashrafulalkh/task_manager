import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth%20screen/reset_password_screen.dart';

class PinVerificationController extends GetxController {
  bool _pinVerificationInProgress = false;

  bool get pinVerificationInProgress => _pinVerificationInProgress;

  Future<bool> pinVerification(String email, String pin) async {
    bool isSuccess = false;
    _pinVerificationInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.otpVerification(email, pin));
    if (response.isSuccess) {
      isSuccess = true;
      Get.offUntil(
          GetPageRoute(page: () => ResetPasswordScreen(otp: pin, email: email)),
          (route) => false);
    }
    _pinVerificationInProgress = false;
    update();

    return isSuccess;
  }
}
