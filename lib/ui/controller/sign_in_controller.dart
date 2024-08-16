import 'package:get/get.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/data/models/login_model.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class SignInController extends GetxController{
  bool _signInApiInProgress = false;

  get signInApiInProgress => _signInApiInProgress;

  Future<bool> singIn(String email,String password) async {
    bool isSuccess = false;
    _signInApiInProgress = true;
    update();

    Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };

    final NetworkResponse networkResponse =
    await NetworkCaller.postRequest(Urls.login, body: requestData);


    if (networkResponse.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(networkResponse.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);

      isSuccess = true;

    }
    _signInApiInProgress = false;
    update();

    return isSuccess;

  }


}