import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/pick_profile_pic_controller.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/user_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgess = false;

  bool get updateProfileInProgess => _updateProfileInProgess;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobileNumber, String password) async {
    bool isSuccess = false;
    _updateProfileInProgess = true;
    String encodedPhoto = AuthController.userData?.photo ?? '';
    update();

    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "mobile": mobileNumber.trim(),
    };

    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }

    if (Get.find<PickProfilePicController>().selectedImage != null) {
      File file =
          File(Get.find<PickProfilePicController>().selectedImage!.path);
      encodedPhoto = base64Encode(file.readAsBytesSync());
      requestBody['photo'] = encodedPhoto;
    }

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.updateProfile, body: requestBody);

    if (response.isSuccess && response.responseData['status'] == 'success') {
      isSuccess = true;
      UserModel userModel = UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobileNumber,
        photo: encodedPhoto,
      );
      await AuthController.saveUserData(userModel);
      update();
    }
    _updateProfileInProgess = false;
    update();

    return isSuccess;
  }
}
