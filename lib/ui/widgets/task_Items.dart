import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/delete_task_controller.dart';
import 'package:task_manager/ui/controller/edit_task_controller.dart';
import 'package:task_manager/ui/data/models/task_model.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class TaskItems extends StatefulWidget {
  const TaskItems({
    super.key,
    required this.taskModel,
    required this.onUpdateTask,
    required this.colors,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;
  final Color? colors;

  @override
  State<TaskItems> createState() => _TaskItemsState();
}

class _TaskItemsState extends State<TaskItems> {
  String dropdownValue = '';

  List<String> statusList = ['New', 'Completed', 'InProgress', 'Cancelled'];

  @override
  void initState() {
    dropdownValue = widget.taskModel.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      color: Colors.white,
      child: ListTile(
        title: Text(widget.taskModel.title ?? 'Unknown'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? 'Unknown'),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Created: ${widget.taskModel.createdDate}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  backgroundColor: widget.colors,
                  label: Text(
                    widget.taskModel.status ?? 'New',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                ),
                OverflowBar(
                  children: [
                    GetBuilder<EditTaskController>(
                        builder: (editTaskController) {
                      return Visibility(
                        visible: editTaskController.editInProgress == false,
                        replacement: const CenteredProgressIndicator(),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.edit),
                          onSelected: (String selected) async {
                            dropdownValue = selected;
                            bool sunccess =
                                await editTaskController.editTaskStatus(
                                    widget.taskModel.sId!,
                                    dropdownValue,
                                    widget.onUpdateTask());

                            if (sunccess) {
                              successSnackbarMassage('Edit', 'Task Status Edit Successflly done');
                            } else {
                              failedSnackbarMassage('Edit',
                                  'Task Status Edit Failed!! Try Again');
                            }

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return statusList.map((String value) {
                              return PopupMenuItem<String>(
                                value: value,
                                child: ListTile(
                                  title: Text(value),
                                  trailing: dropdownValue == value
                                      ? const Icon(Icons.done)
                                      : null,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      );
                    }),
                    GetBuilder<DeleteTaskController>(
                        builder: (deleteTaskController) {
                      return Visibility(
                        visible: deleteTaskController.deleteInProgress == false,
                        replacement: const CenteredProgressIndicator(),
                        child: IconButton(
                          onPressed: () async {
                            bool success =
                                await deleteTaskController.deleteTask(
                              widget.taskModel.sId!,
                              widget.onUpdateTask(),
                            );
                            if (success) {
                              successSnackbarMassage(
                                  'Delete', 'Task Deleted Successfully');
                            } else {
                              failedSnackbarMassage(
                                  'Delete', 'Task Delete Failed!! Try Again');
                            }
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
