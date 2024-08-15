import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth%20screen/pin_verification_screen.dart';

class EmailVerificationController extends GetxController {
  bool _getverifyEmailInprogress = false;

  bool get getVerifyEmailInprogress => _getverifyEmailInprogress;

  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;
    _getverifyEmailInprogress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.verifyEmail(email),);

    if (response.isSuccess) {
      isSuccess = true;
        Get.to(() => PinVerificationScreen(email: email),);
      }
    _getverifyEmailInprogress = false;
    update();

    return isSuccess;
  }
}
