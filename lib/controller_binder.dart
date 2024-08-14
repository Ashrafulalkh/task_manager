import 'package:get/get.dart';
import 'package:task_manager/ui/controller/add_new_task_controller.dart';
import 'package:task_manager/ui/controller/completed_task_controller.dart';
import 'package:task_manager/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';

import 'ui/controller/cancelled_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.lazyPut(()=> NewTaskController());
    Get.lazyPut(() => TaskCountByStatusController());
    Get.lazyPut(() => InProgressTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => CancelledTaskController());
    Get.put(AddNewTaskController());
    Get.put(SignUpController());
  }

}