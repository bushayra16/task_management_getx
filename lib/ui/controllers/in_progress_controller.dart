import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class InProgressController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  List<TaskModel> _inProgressTask = [];
  List<TaskModel> get inProgressTask => _inProgressTask;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.statusData);
      _inProgressTask = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  }