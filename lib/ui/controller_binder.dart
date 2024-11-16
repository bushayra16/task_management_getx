import 'package:get/get.dart';
import 'package:task_management/ui/controllers/add_new_controller.dart';
import 'package:task_management/ui/controllers/cancelled_controller.dart';
import 'package:task_management/ui/controllers/completed_controller.dart';
import 'package:task_management/ui/controllers/forgot_password_controller.dart';
import 'package:task_management/ui/controllers/in_progress_controller.dart';
import 'package:task_management/ui/controllers/new_task_list_controller.dart';
import 'package:task_management/ui/controllers/profile_update_controller.dart';
import 'package:task_management/ui/controllers/set_password_controller.dart';
import 'package:task_management/ui/controllers/sign_up_controller.dart';
import 'package:task_management/ui/controllers/sing_in_controller.dart';
import 'package:task_management/ui/controllers/task_count_controller.dart';
import 'package:task_management/ui/controllers/task_update_controller.dart';
import 'package:task_management/ui/controllers/verify_otp_controller.dart';
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(AddNewController());
    Get.put(CancelledController());
    Get.put(InProgressController());
    Get.put(CompletedController());
    Get.put(TaskCountController());
    Get.put(SignUpController());
    Get.put(ForgotPasswordController());
    Get.put(VerifyOtpController());
    Get.put(SetPasswordController());
    Get.put(TaskUpdateController());
    Get.put(ProfileUpdateController());
  }

}