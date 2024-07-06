import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';
import 'package:task_manager/ui/widgets/task_Items.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getInProgressTaskInProgress = false;
  List<TaskModel> inProgressTaskList = [];

  @override
  void initState() {
    _getInProgressTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _getInProgressTask(),
        child: Visibility(
          visible: _getInProgressTaskInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: inProgressTaskList.length,
            itemBuilder: (context, index) {
              return TaskItems(
                taskModel: inProgressTaskList[index], onUpdateTask: () { },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getInProgressTask() async {
    _getInProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.inProgressTaskList);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      inProgressTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMassage(
            context, response.errorMassage ?? 'Get In Progress Task Failed! Try Again');
      }
    }
    _getInProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

}
