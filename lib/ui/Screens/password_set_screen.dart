import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/Screens/forgot_password_email.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/Screens/sign_up_screen.dart';
import 'package:task_management/ui/controllers/set_password_controller.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class PasswordSetScreen extends StatefulWidget {
  const PasswordSetScreen({super.key, required this.email, required this.otp});
  final String email;
  final String otp;
  static const String name = '/PasswordSet';
  @override
  State<PasswordSetScreen> createState() => _PasswordSetScreenState();
}

class _PasswordSetScreenState extends State<PasswordSetScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SetPasswordController _setPasswordController = Get.find<SetPasswordController>();

  // bool _obscureText = true;

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
                Text('Set Password', style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                Text('Minimum length password 8 character with Letter and number combination', style: textTheme.bodyMedium?.copyWith(fontSize: 15,color: Colors.grey),),
                const SizedBox(height: 20,),
                _buildResetPasswordForm(),
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


  void _onTapConfirmButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _setPassword();
    Get.toNamed(SignInScreen.name);
  }

  Future<void> _setPassword() async {
    final bool result = await _setPasswordController.setPassword(widget.email, widget.otp, _confirmPasswordController.text);
    if (result == false) {
      showSnackBarMessage(context, _setPasswordController.errorMessage!, true);
    }
  }

  Widget _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            obscureText: true,
            controller: _newPasswordController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Password',
            ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter valid password';
                }
                if (value!.length < 6) {
                  return 'Enter valid password must 6 character';
                }
                return null;
              },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Confirm Password'
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter valid password';
              }
              if (value!.length < 6) {
                return 'Enter valid password must 6 character';
              }
              return null;
            },
          ),
          const SizedBox(height: 24,),
          ElevatedButton(onPressed: _onTapConfirmButton,
            child: const  Text('Confirm'),
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

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (_) => false);
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

}


