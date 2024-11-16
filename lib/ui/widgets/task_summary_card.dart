import 'package:flutter/material.dart';
import 'package:task_management/data/model/task_status_count.dart';
import 'package:task_management/data/model/task_status_model.dart';
import 'package:task_management/data/model/task_list_model.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key, required this.taskCountModel,
  });

  final TaskStatusModel taskCountModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: SizedBox(
        width: 99,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskCountModel.sum.toString(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 4,),
              Text(taskCountModel.sId.toString(), style: const TextStyle(color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }
}