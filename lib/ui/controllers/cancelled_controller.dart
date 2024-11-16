import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CancelledController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  List<TaskModel> _cancelledTask = [];
  List<TaskModel> get cancelledTask => _cancelledTask;
  Future<bool> getCanceledList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.canceledTaskList,
    );
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.statusData);
      _cancelledTask = taskListModel.taskList ?? [];
      isSuccess = true;
    } else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
   update();
   return isSuccess;
  }
}