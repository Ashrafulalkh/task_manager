import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  List<TaskModel> _newTaskList = [];
  String _errorMassage = '';

  bool get getNewTaskInProgress => _getNewTaskInProgress;

  List<TaskModel> get newTaskList => _newTaskList;

  String get errorMassage => _errorMassage;

  Future<bool> getNewTask() async {
    bool isSuccess = false;

    _getNewTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      _newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMassage = response.errorMassage ?? 'Get New Task Failed! Try Again';
    }
    _getNewTaskInProgress = false;
    update();

    return isSuccess;
  }
}
