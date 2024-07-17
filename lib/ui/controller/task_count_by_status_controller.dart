import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_by-count_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_count_by_status_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class TaskCountByStatusController extends GetxController {
  bool _getTaskCountByStatusInProgress = false;
  List<TaskCountByStatusModel> _taskCountByStatusList = [];
  String _errorMassage = '';

  get getTaskCountByStatusInProgress => _getTaskCountByStatusInProgress;
  List<TaskCountByStatusModel> get taskCountByStatusList => _taskCountByStatusList;
  String get errorMassage => _errorMassage;

  Future<bool> getTaskCountByStatus() async {
    bool isSuccess = false;
    _getTaskCountByStatusInProgress = true;
    update();

    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
      TaskCountByStatusWrapperModel.fromJson(response.responseData);
      _taskCountByStatusList = taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      _errorMassage = response.errorMassage ?? 'Task Count By Status Failed! Try Again';
      }
    _getTaskCountByStatusInProgress = false;
    update();

    return isSuccess;
    }
  }
