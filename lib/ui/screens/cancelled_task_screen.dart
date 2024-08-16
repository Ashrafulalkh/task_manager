import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/summery_section.dart';
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

  void initialCall() {
    Get.find<CancelledTaskController>().getCancelledTask();
    Get.find<TaskCountByStatusController>().getTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const SummerySection(),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                initialCall();
              },
              child: GetBuilder<CancelledTaskController>(
                  builder: (cancelledTaskController) {
                return Visibility(
                  visible: cancelledTaskController.getCancelledTaskInProgress ==
                      false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount: cancelledTaskController.cancelledTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItems(
                        taskModel:
                            cancelledTaskController.cancelledTaskList[index],
                        onUpdateTask: () {
                          initialCall();
                        }, colors: Colors.red,
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
