import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class AddNewTaskController extends GetxController {
  bool _addNewTaskInProgress = false;

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  Future<bool> addNewTask(String tittle, String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();

    Map<String, dynamic> requestData = {
      "title": tittle,
      "description": description,
      "status": "New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTask,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    }
    _addNewTaskInProgress = false;
    update();

    return isSuccess;
  }
}
