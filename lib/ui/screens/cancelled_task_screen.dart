import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';
import 'package:task_manager/ui/widgets/task_Items.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  @override
  void initState() {
    Get.find<CancelledTaskController>().getCancelledTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async =>
            Get.find<CancelledTaskController>().getCancelledTask(),
        child: GetBuilder<CancelledTaskController>(
            builder: (cancelledTaskController) {
          return Visibility(
            visible:
                cancelledTaskController.getCancelledTaskInProgress == false,
            replacement: const CenteredProgressIndicator(),
            child: ListView.builder(
              itemCount: cancelledTaskController.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskItems(
                  taskModel: cancelledTaskController.cancelledTaskList[index],
                  onUpdateTask: () {},
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
