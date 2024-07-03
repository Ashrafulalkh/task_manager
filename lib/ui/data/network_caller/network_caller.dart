import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/screens/auth%20screen/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url), headers: {
        'token': AuthController.accessToken,
      });
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        redirectToLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      debugPrint(url);
      debugPrint(body.toString());
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'content-type': 'Application/json',
          'token': AuthController.accessToken
        },
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        redirectToLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<void> redirectToLogin() async {
    await AuthController.clearAllData();

    Navigator.pushAndRemoveUntil(
        TaskManager.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false);
  }
}
