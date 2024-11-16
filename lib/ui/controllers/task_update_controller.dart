import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskUpdateController extends GetxController{

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> changeStatus (String sId,String newStatus) async{
    _inProgress = true;
    bool isSuccess = false;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest
      (url: Urls.changeTaskStatus(sId, newStatus));
    if(response.isSuccess){
      isSuccess = true;
    } else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}