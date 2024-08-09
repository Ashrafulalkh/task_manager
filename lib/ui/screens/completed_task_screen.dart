import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/completed_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_Items.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  @override
  void initState() {
    Get.find<CompletedTaskController>().getCompletedTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async =>
            Get.find<CompletedTaskController>().completedTaskList,
        child: GetBuilder<CompletedTaskController>(
            builder: (completedTaskController) {
          return Visibility(
            visible:
                completedTaskController.getCompletedTaskInProgress == false,
            replacement: const CenteredProgressIndicator(),
            child: ListView.builder(
              itemCount: completedTaskController.completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskItems(
                  taskModel: completedTaskController.completedTaskList[index],
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
