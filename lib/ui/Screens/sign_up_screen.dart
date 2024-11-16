import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/controllers/sign_up_controller.dart';
import 'package:task_management/ui/widgets/circular_indicator.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name = '/SignUp';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  final SignUpController signUpController = Get.find<SignUpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 85,),
                Text('Join With Us', style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                const SizedBox(height: 20,),
                _buildSignUpForm(),
                const SizedBox(height: 24,),
                Center(
                  child: Column(
                    children: [
                      _buildSignInSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (String? value){
                        if (value?.isEmpty ?? true) {
                          return 'Enter your email';
                        }else{
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email'
                      ),
                    ),
                                   const SizedBox(height: 10,),
                    TextFormField(
                      controller: _firstNameController,
                        validator: (String? value){
                          if (value?.isEmpty ?? true) {
                            return 'Enter your Name';
                          }else{
                            return null;
                          }
                        },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          hintText: 'First Name'
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _lastNameController,
                      validator: (String? value){
                        if (value?.isEmpty ?? true) {
                          return 'Enter your last Name';
                        }else{
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          hintText: 'Last Name'
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _mobileController,
                      validator: (String? value){
                        if (value?.isEmpty ?? true) {
                          return 'Enter your Phone Number';
                        }else{
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          hintText: 'Mobile'
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _passwordController,
                      validator: (String? value){
                        if (value?.isEmpty ?? true) {
                          return 'Enter your Password';
                        }else{
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          hintText: 'Password'
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const SizedBox(height: 24,),
                    GetBuilder<SignUpController>(
                      builder: (controller) {
                        return Visibility(
                          visible: !signUpController.inProgress,
                          replacement: const CenterCircularIndicator(),

                          child: ElevatedButton(onPressed: _onTapLoginButton,
                              child: const  Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }
                    ),
                  ],
                ),
    );

  }
  Widget _buildSignInSection() {
    return RichText(text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5
        ),
        text: "Have account? ",
        children: [
          TextSpan(
              style: const TextStyle(
                  color: AppColors.themeColor
              ),
              text: 'Sign In',
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn

          )
        ]
    )
    );
  }
  void _onTapLoginButton () {
    if(!_formKey.currentState!.validate()){
      return;
    } else{
     _signup();
    }
  }
  void _onTapSignIn () {
    Navigator.pop(context);
  }

  Future<void> _signup () async{
    final bool result = await signUpController.signup(_emailController.text.trim(), _firstNameController.text.trim(), _lastNameController.text.trim(), _mobileController.text.trim(), _passwordController.text);
    if(result== true){
      _clearTextFields();
      Get.back();
      showSnackBarMessage(context,'New User Created', );
    }else{
      showSnackBarMessage(context, signUpController.errorMessage!,  true);
    }
  }

  void _clearTextFields () {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();

  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

}


