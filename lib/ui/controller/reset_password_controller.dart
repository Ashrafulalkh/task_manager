import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth%20screen/sign_in_screen.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;

  bool get resetPasswordInProgress => _resetPasswordInProgress;

  Future<bool> resetPassword(String email, String otp, String password) async {
    bool isSuccess = false;
    _resetPasswordInProgress = true;
    update();

    Map<String, dynamic> resetPasswordRequestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        Urls.resetPassword,
        body: resetPasswordRequestBody);

    if (response.isSuccess) {
      isSuccess = true;
      Get.offUntil(
          GetPageRoute(
            page: () => const SignInScreen(),
          ),
          (route) => false);
    }
    _resetPasswordInProgress = false;
    update();

    return isSuccess;
  }
}
