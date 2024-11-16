import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class VerifyOtpController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  bool isSuccess = false;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future <bool> verifyOtp (String email, String password) async {
    _inProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getOtp(email, password));
    if (response.isSuccess){
      isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}