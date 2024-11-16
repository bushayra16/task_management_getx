
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controllers/cancelled_controller.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_msg.dart';
import '../widgets/task_update_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});
  static const String name = '/cancelledTask';
  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {

 CancelledController cancelledController = Get.find<CancelledController>();

  @override
  void initState() {
    _getCanceledList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCanceledList();
        },
        child: GetBuilder<CancelledController>(
          builder: (controller) {
            return Visibility(
              visible: !controller.inProgress,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                itemCount: cancelledController.cancelledTask.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                      taskModel: cancelledController.cancelledTask[index],
                      onRefreshList: _getCanceledList,
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

  Future<void> _getCanceledList() async {
    final bool result = await cancelledController.getCanceledList();
    if (result == false) {
      showSnackBarMessage(context, cancelledController.errorMessage!, true);
    }
  }
}