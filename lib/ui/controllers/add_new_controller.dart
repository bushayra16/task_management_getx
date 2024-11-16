import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_msg.dart';

class AddNewController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask (String title, String description) async{
    bool isSuccess = false;
   _inProgress = true;
    update();
    Map<String,dynamic> requestTask = {
      "title": title,
      "description": description,
      "status" : "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestTask);

    if(response.isSuccess){
      isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}