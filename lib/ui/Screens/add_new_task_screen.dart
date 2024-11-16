import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/Screens/new_task_screen.dart';
import 'package:task_management/ui/controllers/add_new_controller.dart';
import 'package:task_management/ui/widgets/app_bar.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static const String name = '/addNewTask';
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}
class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

 final TextEditingController _titleController = TextEditingController();
 final TextEditingController _descriptionController = TextEditingController();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 AddNewController addNewController = Get.find<AddNewController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
        appBar: const TMAppbar(),
        body: BackgroundScreen(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 85,),
                    Text('Add New Task', style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500),),
                    const SizedBox(height: 12,),
                    _buildNewTaskForm(),
                    const SizedBox(height: 45,),
      
                  ],
                ),
              ),
            ),
          ),
        ),

    );
  }

  Widget _buildNewTaskForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          TextFormField(
            controller: _titleController,
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return 'Enter Your Task Title';
              } else{
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Title'
            ),
          ),
          const SizedBox(height: 8,),
          TextFormField(
            controller: _descriptionController,
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return 'Enter Your Task Description';
              } else{
                return null;
              }
            },
            maxLines: 6,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Description'
            ),
          ),
          const SizedBox(height: 15,),
          GetBuilder<AddNewController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const CircularProgressIndicator(),
                child: ElevatedButton(onPressed: _onTapSubmitButton,
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
              );
            }
          ),

        ],
      ),
    );
  }

  void _onTapSubmitButton() {
    if(!_formKey.currentState!.validate()){
      return;
    }
    _addNewTask();
  }

  Future<void> _addNewTask () async{
    final bool result = await addNewController.
    addNewTask(_titleController.text.trim(), _descriptionController.text.trim());
    if(result){
      Get.back(result: true);
     showSnackBarMessage(context, 'New Task Added');
    }
    else{
     showSnackBarMessage(context, addNewController.errorMessage!, true );
    }
  }
  void _clearTextFields () {
    _titleController.clear();
    _descriptionController.clear();
  }
 @override
 void dispose() {
   super.dispose();
   _titleController.dispose();
   _descriptionController.dispose();
 }
}