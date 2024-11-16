import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CompletedController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  List<TaskModel> _getCompletedTask = [];
  List<TaskModel> get getCompletedTask => _getCompletedTask;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.completedTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.statusData);
      _getCompletedTask = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}