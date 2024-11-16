import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/Screens/profile_screen.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/utils/assets_path.dart';

import '../controllers/auth_controllers.dart';
import '../utils/app_colors.dart';

class TMAppbar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppbar({
    super.key, this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (isProfileScreenOpen){
          return;
        }
        Get.to(const ProfileScreen());
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: (
            Row(
              children: [
                 CircleAvatar(backgroundColor: Colors.white,
                   backgroundImage: (AuthControllers.userData?.photo != null && AuthControllers.userData!.photo!.isNotEmpty)
                       ? MemoryImage(base64Decode(AuthControllers.userData!.photo!))
                       : null, // Use a default image or leave null

                ),
                const SizedBox(width: 15,),
                  Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(AuthControllers.userData?.fullName ?? '', style: const TextStyle(color: Colors.white, fontSize: 16),),
                      Text(AuthControllers.userData?.email ?? ' ', style: const TextStyle(color: Colors.white, fontSize: 12),)
                    ],
                  ),
                ),
                IconButton(onPressed: () async {
                  await AuthControllers.clearUserData();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (value) => false
                  );
                }, icon: const Icon(Icons.logout))
              ],
            )
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}