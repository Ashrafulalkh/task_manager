import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTaskInProgress = true;
  List<TaskModel> _cancelledTaskList = [];
  String _errorMassage = '';

  bool get getCancelledTaskInProgress => _getCancelledTaskInProgress;

  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  String get errorMassage => _errorMassage;

  Future<bool> getCancelledTask() async {
    bool isSuccess = false;
    _getCancelledTaskInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.cancelledTaskList);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _cancelledTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMassage =
          response.errorMassage ?? 'Get Cancelled Task Failed! Try Again';
    }

    _getCancelledTaskInProgress = false;
    update();

    return isSuccess;
  }
}
