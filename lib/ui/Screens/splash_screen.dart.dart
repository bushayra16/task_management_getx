import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/Screens/main_bottom_nav_bar.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/controllers/auth_controllers.dart';
import 'package:task_management/ui/utils/assets_path.dart';

import '../widgets/screen_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _moveToNewScreen();
    // TODO: implement initState
    super.initState();
  }

  Future <void> _moveToNewScreen () async{
  await Future.delayed(const Duration(seconds: 2));

  await AuthControllers.getAccessToken();
  if(AuthControllers.isLoggedIn()){
    await AuthControllers.getUserData();
    Get.offAllNamed(BottomNavBar.name);
    } else{
    Get.offAllNamed(SignInScreen.name);
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: BackgroundScreen(
         child:  Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children:[
                Center( child:
                   SvgPicture.asset(
                     AssetsPath.logoSvg,
                     width: 120,)

                 ),
               ]),
         ));
  }
}





