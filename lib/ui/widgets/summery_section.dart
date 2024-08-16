import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_summery_card.dart';

class SummerySection extends StatelessWidget {
  const SummerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskCountByStatusController>(
        builder: (taskCountByStatusController) {
          return Visibility(
            visible:
            taskCountByStatusController.getTaskCountByStatusInProgress == false,
            replacement: const SizedBox(
              height: 100,
              child: CenteredProgressIndicator(),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                taskCountByStatusController.taskCountByStatusList.map((e) {
                  return TaskSummeryCard(
                    count: e.sum.toString(),
                    title: (e.sId ?? 'Unknown').toUpperCase(),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
