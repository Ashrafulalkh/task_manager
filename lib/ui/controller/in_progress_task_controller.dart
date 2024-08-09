import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class InProgressTaskController extends GetxController {
  bool _getInProgressTaskInProgress = false;
  List<TaskModel> _inProgressTaskList = [];
  String _errorMassage = '';

  bool get getInProgressTaskInProgress => _getInProgressTaskInProgress;
  List<TaskModel> get inProgressTaskList => _inProgressTaskList;
  String get errorMassage => _errorMassage;

  Future<bool> getInProgressTask() async {
    bool isSuccess = false;
    _getInProgressTaskInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.inProgressTaskList);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _inProgressTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMassage =
          response.errorMassage ?? 'Get In Progress Task Failed! Try Again';
    }
    _getInProgressTaskInProgress = false;
    update();

    return isSuccess;
  }
}
