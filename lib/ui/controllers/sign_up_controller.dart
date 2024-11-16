import 'package:get/get.dart';
import '../../data/model/login_model.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controllers.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signup(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> registrationData = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'password': password
    };

    NetworkResponse response = await NetworkCaller.postRequest
      (url: Urls.registration, body: registrationData);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
