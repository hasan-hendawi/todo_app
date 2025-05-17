import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/fireDataBase.dart';
import 'package:todo_app/database/models/task_model.dart';
import 'package:todo_app/database/models/user_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/tasks/task_item.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late DateTime _selectedDate;
  UserModel? userModel;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: height * 0.17,
          leadingWidth: width,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  user.currentUser?.name?? "name error",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              CalendarTimeline(
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) => setState(() {
                  _selectedDate = date;
                }),
                leftMargin: 12,
                monthColor: Colors.white,
                dayColor: Colors.white,
                dayNameColor: Colors.white,
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.black54,
                dotColor: Colors.white,
                locale: 'en',
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FireDataBase.getRealTimeTask(
              user.currentUser?.id ?? "id error",
              DateTime(_selectedDate.year, _selectedDate.month,
                      _selectedDate.day)
                  .millisecondsSinceEpoch),
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return Center(
                child: Text(snapShot.error.toString()),
              );
            }
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var tasksList =
                snapShot.data?.docs.map((doc) => doc.data()).toList();

            if (tasksList?.isEmpty == true) {
              return Center(
                child: Text(LocaleKeys.noTaskYet.tr()),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskItem(
                  taskModel: tasksList[index],
                  userId: user.currentUser?.id ?? "",
                  parentContext: context,
                );
              },
              itemCount: tasksList!.length,
            );
          },
        ),
      ),
    );
  }


}
