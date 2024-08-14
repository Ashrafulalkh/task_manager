import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth%20screen/sign_in_screen.dart';

class SignUpController extends GetxController {
  bool _registrationInprogress = false;

  bool get registrationInprogress => _registrationInprogress;

  Future<bool> register(String email, String firstName, String lastName,
      String mobileNumber, String password) async {
    bool isSuccess = false;
    _registrationInprogress = true;
    update();

    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobileNumber,
      "password": password,
      "photo": ""
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, body: requestInput);

    if (response.isSuccess) {
      isSuccess = true;
      Get.to(() => const SignInScreen());
    }

    _registrationInprogress = false;
    update();

    return isSuccess;
  }
}
