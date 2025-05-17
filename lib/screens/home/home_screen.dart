import 'package:flutter/material.dart';
import 'package:todo_app/screens/home/widgets/add_task_bottom_sheet.dart';
import 'package:todo_app/screens/settings/settings_screen.dart';
import 'package:todo_app/screens/tasks/tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  static const homeScreenRouteName = "homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    TasksScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

      // 1. Add the FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0), // Rounded top corners
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary, // Background color of the sheet
            context: context,
            builder: (BuildContext context) {
              return AddTaskBottomSheet();
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 2. Use BottomAppBar with a notch
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: SizedBox(
          height: 60, // Adjust height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tasks Icon
              IconButton(
                icon: Icon(
                  Icons.list,
                  color: selectedIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
              ),
              // Spacer for FAB
              SizedBox(width: 40), // Space for the FAB in the center
              // Settings Icon
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: selectedIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
