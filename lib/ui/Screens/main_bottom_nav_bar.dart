import 'package:flutter/material.dart';
import 'package:task_management/ui/Screens/canceled_screen.dart';
import 'package:task_management/ui/Screens/completed_screen.dart';
import 'package:task_management/ui/Screens/new_task_screen.dart';
import 'package:task_management/ui/Screens/progress_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';

import '../widgets/app_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
 static const String name = '/home';
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screen = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override

  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
       appBar: const  TMAppbar(),
       body: _screen[_selectedIndex],
       bottomNavigationBar: NavigationBar(
         selectedIndex: _selectedIndex,
         onDestinationSelected: (int index){
           _selectedIndex = index;
           setState(() {

           });
         },
         destinations: const [
           NavigationDestination(
               icon: Icon(Icons.new_label), label: "New Task"),
           NavigationDestination(
               icon: Icon(Icons.check), label: "Completed"),
           NavigationDestination(
               icon: Icon(Icons.close), label: "Canceled"),
           NavigationDestination(
               icon: Icon(Icons.access_time_outlined), label: "Progress"),

         ],
       ),
    );
  }
}



