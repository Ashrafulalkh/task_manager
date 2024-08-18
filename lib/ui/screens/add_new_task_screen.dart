import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/add_new_task_controller.dart';
import 'package:task_manager/ui/widgets/background_widgets.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackGroundWidgets(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AddNewTaskController>(
                      builder: (addNewTaskController) {
                    return Visibility(
                      visible:
                          addNewTaskController.addNewTaskInProgress == false,
                      replacement: const CenteredProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool success =
                                await Get.find<AddNewTaskController>()
                                    .addNewTask(
                              _titleTEController.text.trim(),
                              _descriptionTEController.text.trim(),
                            );
                            if (success) {
                              clearTextFields();
                              successSnackbarMassage('Success', 'New Task Added Successfully');
                            } else {
                              failedSnackbarMassage('Failed', 'Add New Task Failed!! Try Again');
                            }
                          }
                        },
                        child: const Text('Add'),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearTextFields() {
    _descriptionTEController.clear();
    _titleTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
