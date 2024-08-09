import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];
  String _errorMassage = '';

  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;

  List<TaskModel> get completedTaskList => _completedTaskList;

  String get errorMassage => _errorMassage;

  Future<bool> getCompletedTask() async {
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _completedTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMassage = response.errorMassage ?? 'Get New Task Failed! Try Again';
    }
    _getCompletedTaskInProgress = false;
    update();

    return isSuccess;
  }
}
