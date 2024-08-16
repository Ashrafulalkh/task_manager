import 'package:get/get.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';

class EditTaskController extends GetxController {
 bool _editInProgress = false;

 bool get editInProgress => _editInProgress;

  Future<bool> editTaskStatus(String sid, String dropDown, void onupdate) async {
    bool isSuccess = false;
    _editInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.editTask(sid, dropDown));

    if (response.isSuccess) {
      isSuccess = true;
      onupdate;
    }

    _editInProgress = false;
    update();

    return isSuccess;
  }

}