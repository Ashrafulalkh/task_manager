import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/models/task_by-count_wrapper_model.dart';
import 'package:task_manager/ui/data/models/task_count_by_status_model.dart';
import 'package:task_manager/ui/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';
import 'package:task_manager/ui/widgets/task_Items.dart';
import 'package:task_manager/ui/widgets/task_summery_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskCountByStatusInProgress = false;

  List<TaskCountByStatusModel> taskCountByStatusList = [];

  @override
  void initState() {
    initialCall();
    super.initState();
  }

  void initialCall() {
    Get.find<NewTaskController>().getNewTask();
    _getTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            _buildSummerySection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  initialCall();
                },
                child:
                    GetBuilder<NewTaskController>(builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskInProgress == false,
                    replacement: const CenteredProgressIndicator(),
                    child: ListView.builder(
                      itemCount: newTaskController.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskItems(
                          taskModel: newTaskController.newTaskList[index],
                          onUpdateTask: () {
                            initialCall();
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _onTapAddButton();
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }

  Widget _buildSummerySection() {
    return Visibility(
      visible: _getTaskCountByStatusInProgress == false,
      replacement: const SizedBox(
        height: 100,
        child: CenteredProgressIndicator(),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: taskCountByStatusList.map((e) {
            return TaskSummeryCard(
              count: e.sum.toString(),
              title: (e.sId ?? 'Unknown').toUpperCase(),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);
      taskCountByStatusList =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      if (mounted) {
        showSnackBarMassage(context,
            response.errorMassage ?? 'Task Count By Status Failed! Try Again');
      }
    }
    _getTaskCountByStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
