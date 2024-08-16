import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/summery_section.dart';
import 'package:task_manager/ui/widgets/task_Items.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  void initState() {
    initialCall();
    super.initState();
  }

  void initialCall() {
    Get.find<InProgressTaskController>().getInProgressTask();
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
              child: GetBuilder<InProgressTaskController>(
                  builder: (inProgressTaskController) {
                return Visibility(
                  visible:
                      inProgressTaskController.getInProgressTaskInProgress ==
                          false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount:
                        inProgressTaskController.inProgressTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItems(
                        taskModel:
                            inProgressTaskController.inProgressTaskList[index],
                        onUpdateTask: () {
                          initialCall();
                        }, colors: Colors.orangeAccent,
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
