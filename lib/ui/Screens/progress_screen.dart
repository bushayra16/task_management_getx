import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controllers/in_progress_controller.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_update_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});
  static const String name = '/InProgress';
  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  InProgressController inProgressController = Get.find<InProgressController>();

  @override
  void initState() {
    _getProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: RefreshIndicator(
        onRefresh: () async {
          _getProgressTaskList();
        },
        child: GetBuilder<InProgressController>(
          builder: (controller) {
            return Visibility(
              visible: !controller.inProgress,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                itemCount: controller.inProgressTask.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                      taskModel: controller.inProgressTask[index],
                      onRefreshList: _getProgressTaskList,
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

  Future<void> _getProgressTaskList() async {
    final bool result = await inProgressController.getProgressTaskList();
    if (result == false) {
      showSnackBarMessage(context, inProgressController.errorMessage!, true);
    }
  }

}
