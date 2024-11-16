import 'package:get/get.dart';
import 'package:task_management/data/model/task_status_count.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskCountController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<TaskStatusModel> _taskCountList = [];

  List<TaskStatusModel> get taskCountList => _taskCountList;

  Future<bool> getTaskStatusCount() async{
     bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getTaskCount());
    if(response.isSuccess){
       TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(response.statusData);
      _taskCountList = taskStatusCountModel.taskStatusCountList ?? [];
      isSuccess = true;
    } else{
     _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}