import 'package:get/get.dart';
import '../../data/model/login_model.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controllers.dart';

class SetPasswordController extends GetxController{
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> setPassword(String email, String otp, String password) async {
   _inProgress = true;
   update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.setPassword(),
      body: requestBody,
    );
    if (response.isSuccess) {
     isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return isSuccess;

  }
}