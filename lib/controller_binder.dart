import 'package:get/get.dart';
import 'package:task_manager/ui/controller/add_new_task_controller.dart';
import 'package:task_manager/ui/controller/completed_task_controller.dart';
import 'package:task_manager/ui/controller/delete_task_controller.dart';
import 'package:task_manager/ui/controller/edit_task_controller.dart';
import 'package:task_manager/ui/controller/email_verification_controller.dart';
import 'package:task_manager/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/controller/pick_profile_pic_controller.dart';
import 'package:task_manager/ui/controller/pin_verification_controller.dart';
import 'package:task_manager/ui/controller/reset_password_controller.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';
import 'package:task_manager/ui/controller/update_profile_controller.dart';
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
    Get.put(EmailVerificationController());
    Get.put(PinVerificationController());
    Get.put(ResetPasswordController());
    Get.put(PickProfilePicController());
    Get.put(UpdateProfileController());
    Get.put(DeleteTaskController());
    Get.put(EditTaskController());
  }

}