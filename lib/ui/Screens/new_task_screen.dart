import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/model/task_status_count.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/model/task_status_model.dart';
import 'package:task_management/data/model/task_list_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/Screens/add_new_task_screen.dart';
import 'package:task_management/ui/controllers/new_task_list_controller.dart';
import 'package:task_management/ui/controllers/task_count_controller.dart';
import 'package:task_management/ui/widgets/circular_indicator.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';
import 'package:task_management/data/model/task_model.dart';
import '../widgets/task_update_card.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static const String name = '/newTask';
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  final NewTaskListController newTaskListController = Get.find<
      NewTaskListController>();
  final TaskCountController taskCountController = Get.find<
      TaskCountController>();

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTaskList();
                  _getTaskStatusCount();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GetBuilder<TaskCountController>(
                        builder: (controller) {
                          return Row(
                            children: controller.taskCountList
                                .map(
                                  (e) =>
                                  TaskSummaryCard(
                                      taskCountModel: e),)
                                .toList(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: GetBuilder<NewTaskListController>(
                        builder: (controller) {
                          return Visibility(
                            visible: !controller.inProgress,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ListView.separated(
                              itemCount: controller.getNewTask.length,
                              itemBuilder: (context, index) {
                                return TaskCard(
                                  taskModel: controller.getNewTask[index],
                                  onRefreshList: _getNewTaskList,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 16,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        floatingActionButton: FloatingActionButton(
            onPressed: _onTapButton,
            child: const Icon(Icons.add
            )));
  }

  void _onTapButton() async {
    final bool? shouldRefresh = await
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
    if (shouldRefresh == true) {
      _getNewTaskList();
      _getTaskStatusCount();
    }
  }

  Future<void> _getNewTaskList() async {
    final bool result = await newTaskListController.getNewTaskList();
    if (result == false) {
      showSnackBarMessage(context, newTaskListController.errorMessage!, true);
    }
  }

  Future<void> _getTaskStatusCount() async {
    final bool result = await taskCountController.getTaskStatusCount();
    if (result == false) {
      showSnackBarMessage(context, newTaskListController.errorMessage!, true);
    }
  }
}

