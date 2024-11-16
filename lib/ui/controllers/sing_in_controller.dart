import 'package:get/get.dart';
import '../../data/model/login_model.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controllers.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: loginData);
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.statusData);
      await AuthControllers.saveAccessToken(loginModel.token!);
      await AuthControllers.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}