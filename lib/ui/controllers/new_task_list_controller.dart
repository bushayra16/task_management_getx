import 'package:get/get.dart';
import 'package:task_management/data/model/task_model.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskListController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  List<TaskModel> _getNewTask = [];
  List<TaskModel> get getNewTask => _getNewTask;

  Future<bool> getNewTaskList() async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getNewTaskList);
    if(response.isSuccess){
      final TaskListModel taskListModel = TaskListModel.fromJson(response.statusData);
      _getNewTask = taskListModel.taskList ?? [];
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}