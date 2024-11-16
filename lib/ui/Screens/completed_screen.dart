
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/model/task_list_model.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/controllers/completed_controller.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';
import '../../data/services/network_caller.dart';
import '../widgets/task_update_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static const String name = '/completedTask';
  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  CompletedController completedController = Get.find<CompletedController>();

  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
        child: GetBuilder<CompletedController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  itemCount: controller.getCompletedTask.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskModel: controller.getCompletedTask[index],
                      onRefreshList: _getCompletedTaskList,
                    );
                  },
                  separatorBuilder: (context, builder) {
                    return const SizedBox(height: 10,);
                  },
                ),
              );
            }
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    final bool result = await completedController.getCompletedTaskList();
    if (result == false) {
      showSnackBarMessage(context, completedController.errorMessage!, true);
    }
  }
}

