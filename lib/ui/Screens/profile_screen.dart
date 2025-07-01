import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/controllers/auth_controllers.dart';
import 'package:task_management/ui/widgets/app_bar.dart';
import 'package:task_management/ui/widgets/circular_indicator.dart';

import '../../data/model/network_response.dart';
import '../../data/model/user_model.dart';
import '../../data/services/network_caller.dart';
import '../widgets/snack_bar_msg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData () {
    _emailController.text = AuthControllers.userData?.email ?? '' ;
    _firstNameController.text = AuthControllers.userData?.firstName ?? '' ;
    _lastNameController.text = AuthControllers.userData?.lastName ?? '' ;
    _mobileController.text = AuthControllers.userData?.mobile ?? '' ;
  }

  XFile? insertedImage;
  bool _updateProfileInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const  TMAppbar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48,),
              Text('Update Profile', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              _buildProfileUpdateForm()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildProfileUpdateForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildPhotoPicker(),
          const SizedBox(height: 8,),
          TextFormField(
            enabled: false,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            validator: (String? value){
              if(value?.trim().isEmpty ?? true){
                return ('Enter your email');
              } else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8,),
          TextFormField(
            controller: _firstNameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'First Name',
            ),
            validator: (String? value){
              if(value?.trim().isEmpty ?? true){
                return ('Enter your First Name');
              } else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8,),
          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
            validator: (String? value){
              if(value?.trim().isEmpty ?? true){
                return ('Enter your Last Name');
              } else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8,),
          TextFormField(
            controller: _passWordController,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Password'
            ),

          ),
          const SizedBox(height: 8,),
          TextFormField(
            controller: _mobileController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Mobile',
            ),
            validator: (String? value){
              if(value?.trim().isEmpty ?? true){
                return ('Enter your Number');
              } else{
                return null;
              }
            },
          ),

          const SizedBox(height: 24,),
          Visibility(
            visible: _updateProfileInProgress == false,
            replacement: const CenterCircularIndicator(),
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _updateProfile();
              },
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );}
  Widget _buildPhotoPicker(){
    return GestureDetector(
      onTap: _selectedImage,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 100,
              decoration: const  BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
              ),
              alignment: Alignment.center,
              child: const Text('Photo', style: TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(width: 20,),
            Text(_getSelectedPhotoTitle(), style: const TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passWordController.text.isNotEmpty) {
      requestBody['password'] = _passWordController.text;
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

    _updateProfileInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthControllers.saveUserData(userModel);
      Get.back();
      showSnackBarMessage(context, 'Profile has been updated!');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  String _getSelectedPhotoTitle () {
    if(insertedImage != null) {
      return insertedImage!.name;
    }
    return 'Select Photo';
  }

  Future<void> _selectedImage() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      insertedImage = pickedImage;
      setState(() {
      });
    }
  }
}
