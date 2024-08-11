import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class AddNewTaskController extends GetxController {
  bool _addNewTaskInProgress = false;
  String _errorMassage = '';

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  String get errorMassage => _errorMassage;

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
    } else {
      _errorMassage = response.errorMassage ?? 'Add New Task Failed!';
    }
    _addNewTaskInProgress = false;
    update();

    return isSuccess;
  }
}
