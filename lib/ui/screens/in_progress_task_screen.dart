import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_Items.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  void initState() {
    Get.find<InProgressTaskController>().getInProgressTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async =>
            Get.find<InProgressTaskController>().getInProgressTask(),
        child: GetBuilder<InProgressTaskController>(
            builder: (inProgressTaskController) {
          return Visibility(
            visible:
                inProgressTaskController.getInProgressTaskInProgress == false,
            replacement: const CenteredProgressIndicator(),
            child: ListView.builder(
              itemCount: inProgressTaskController.inProgressTaskList.length,
              itemBuilder: (context, index) {
                return TaskItems(
                  taskModel: inProgressTaskController.inProgressTaskList[index],
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
