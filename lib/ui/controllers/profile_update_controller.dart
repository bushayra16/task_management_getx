import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/network_response.dart';
import '../../data/model/user_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controllers.dart';

class ProfileUpdateController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? _successMessage;

  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;

  XFile? insertedImage;

  Future<bool> updateProfile(String password,String email, String firstName, String lastName, String mobile) async {
    _inProgress = true;
    bool isSuccess = false;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    if (password != '') {
      requestBody['password'] = password;
    }

    if (insertedImage != null) {
      List<int> imageBytes = await insertedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.profileUpdate,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthControllers.saveUserData(userModel);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}