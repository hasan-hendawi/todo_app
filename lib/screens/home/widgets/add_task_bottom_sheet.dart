import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/dialog_utils.dart';
import 'package:todo_app/database/fireDataBase.dart';
import 'package:todo_app/database/models/task_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/auth/widgets/custom_text_field.dart';
import 'package:todo_app/utils/date_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late final TextEditingController newTaskTitleController;
  late final TextEditingController newTaskDescreptionController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newTaskTitleController = TextEditingController();
    newTaskDescreptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // To avoid keyboard overlap
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.addNewTaskTitle.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                LocaleKeys.taskTitle.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              CustomTextField(
                validate: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return LocaleKeys.required.tr();
                    } else if (value.length < 2) {
                      return LocaleKeys.titleShort.tr();
                    }
                  }
                  return null;
                },
                controller: newTaskTitleController,
                hintText: LocaleKeys.enterTaskTitle.tr(),
                labelText: LocaleKeys.taskTitle.tr(),
              ),
              SizedBox(height: 20),
              Text(
                LocaleKeys.taskDesc.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              CustomTextField(
                validate: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return LocaleKeys.required.tr();
                    } else if (value.length < 5) {
                      return LocaleKeys.descShort.tr();
                    }
                  }
                  return null;
                },
                controller: newTaskDescreptionController,
                hintText: LocaleKeys.enterTaskDesc.tr(),
                labelText: LocaleKeys.taskDesc.tr(),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Text(
                LocaleKeys.date.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () => showTaskDatePicker(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text('${CustomDateUtils.formattedDate(selectedDate)}'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      DialogUtils.showLoadingDialog(context);
                      var userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      print(userProvider.currentUser?.id);
                      var task = TaskModel(
                          taskDate: DateTime(selectedDate.year,
                              selectedDate.month, selectedDate.day),
                          desc: newTaskDescreptionController.text,
                          title: newTaskTitleController.text);

                      // Ensure the user is fetched before proceeding
                      await userProvider.getUser();
                      //future<UserModel>!= UserModel ==>future<UserModel>.id =>Error
                      // Safely check if the user exists before accessing the id
                      var userId = userProvider.currentUser?.id;
                      await FireDataBase.addTask(task, userId ?? "");
                      // await FireDataBase.addTask(task, userId);
                      DialogUtils.hideDialog(context);
                      DialogUtils.showMessage(context,
                          message: LocaleKeys.addTaskSuccess.tr(),
                          postActionName: LocaleKeys.ok.tr(), postAction: () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: Text(LocaleKeys.confirmNewTask.tr()),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  void showTaskDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate == null) return;
    selectedDate = pickedDate;
    setState(() {});
  }
}
