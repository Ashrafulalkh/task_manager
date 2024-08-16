import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class DeleteTaskController extends GetxController {
  bool _deleteInProgress = false;

  bool get deleteInProgress => _deleteInProgress;

  Future<bool> deleteTask(String sid, void onUpdate) async {
    bool isSuccess = false;
    _deleteInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTask(sid));
    if (response.isSuccess) {
      isSuccess = true;
      onUpdate;
    }
    _deleteInProgress = false;
    update();

    return isSuccess;
  }
}
