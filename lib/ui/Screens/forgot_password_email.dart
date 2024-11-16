import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/ui/Screens/forgot_password_otp_screen.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/controllers/forgot_password_controller.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/circular_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';

import '../../data/utils/urls.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});
  static const String name = '/verificationEmail';
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _verifyEmailInProgress = false;
  final ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();

  @override

  Widget build(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 85,),
                  Text('Your Email Address', style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 8,),
                  Text('A 6 Digit Verification PIN will send to your email address', style: textTheme.bodyMedium?.copyWith(fontSize: 15,color: Colors.grey),),
                  const SizedBox(height: 12,),
                  _buildVerifyEmailForm(),
                  const SizedBox(height: 45,),
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
      ),
    );
  }


  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email'
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid email';
                        }
                        if (!value!.contains('@')) {
                          return "Enter valid email '@'";
                        }
                        if (!value.contains('.com')) {
                          return "Enter valid email '.com'";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15,),
                    Visibility(
                      visible: _verifyEmailInProgress = true,
                      replacement: const CenterCircularIndicator(),
                      child: ElevatedButton(onPressed: _onTapVerifyButton,
                        child: const  Text('Verify'),
                      ),
                    ),

                  ],
                ),
    );

  }
  void _onTapVerifyButton () {
    if(!_formKey.currentState!.validate()){
      return;
    }
    else{
      _verifyEmail();
      Get.to(ForgotOtpScreen(verifyEmail: _emailController.text.trim()));
    }
  }

  Future <void> _verifyEmail () async {
   final bool result = await forgotPasswordController.verifyEmail(_emailController.text.trim());
   if (result == false){
    showSnackBarMessage(context, forgotPasswordController.errorMessage!);
   }
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
  void _onTapSignIn () {
    Get.back();
  }

}


