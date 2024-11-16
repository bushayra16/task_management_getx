import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/ui/controllers/task_update_controller.dart';
import 'package:task_management/ui/widgets/circular_indicator.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';import '../../data/utils/urls.dart';


import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel,
    required this.onRefreshList
  });
   final TaskModel taskModel;
   final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;
  final TaskUpdateController _taskUpdateController = Get.find<TaskUpdateController>();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(widget.taskModel.title ?? '', style: Theme.of(context).textTheme.titleSmall?.copyWith(),),
            Text(widget.taskModel.description ?? '',),
            Text('Date: ${widget.taskModel.createdDate}',),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTaskStatusChip(),
                Wrap(
                  children: [
                    Visibility(
                      visible: _changeStatusInProgress == false,
                      replacement: const CenterCircularIndicator(),
                      child: IconButton(
                          onPressed: _onTapEditButton, icon: const Icon(Icons.edit)),
                    )
                    ,
                    Visibility(
                        visible: _deleteTaskInProgress == false,
                        replacement: const CenterCircularIndicator(),
                        child: IconButton(onPressed: _onTapDeleteButton, icon: const Icon(Icons.delete,color: Colors.red,)))

                  ],
                )


              ],
            )

          ],
        ),
      ),
    );
  }

  Widget buildTaskStatusChip() {
    return Chip(
                label: Text(widget.taskModel.status!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.themeColor)
                ),
              );
  }

  void _onTapEditButton() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Edit Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['New','Completed','Cancelled','Progress'].map((value){
            return ListTile(
              onTap: (){
                _changeStatus(value);
                Navigator.pop(context);
              },
              title: Text(value),
              selected: _selectedStatus == value,
              trailing: _selectedStatus == value ? const Icon(Icons.check) : null,
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: (){}, child: const Text('Okay')),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Cancel')),

        ],
      );
    });
  }
  Future<void> _changeStatus (String newStatus) async{
    final bool result = await _taskUpdateController.changeStatus(widget.taskModel.sId!, newStatus);
    if(result){
      widget.onRefreshList();
    } else{
      showSnackBarMessage(context, _taskUpdateController.errorMessage!, true);
    }
  }
  void _onTapDeleteButton() async{
    _deleteTaskInProgress = true;
    setState(() {
    });
    final NetworkResponse response = await NetworkCaller.getRequest
      (url: Urls.deleteTask(widget.taskModel.sId!));
    if(response.isSuccess){
      widget.onRefreshList();
    } else{
      _deleteTaskInProgress = false;
      setState(() {

      });
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
  }
