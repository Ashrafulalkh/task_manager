import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/completed_task_controller.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/summery_section.dart';
import 'package:task_manager/ui/widgets/task_Items.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    initialCall();
    super.initState();
  }

  void initialCall() {
    Get.find<CompletedTaskController>().getCompletedTask();
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
              child: GetBuilder<CompletedTaskController>(
                  builder: (completedTaskController) {
                return Visibility(
                  visible: completedTaskController.getCompletedTaskInProgress ==
                      false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount: completedTaskController.completedTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItems(
                        taskModel:
                            completedTaskController.completedTaskList[index],
                        onUpdateTask: () {
                          initialCall();
                        }, colors: Colors.green,
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
