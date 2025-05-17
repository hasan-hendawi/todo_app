import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/dialog_utils.dart';
import 'package:todo_app/database/fireDataBase.dart';
import 'package:todo_app/database/models/task_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.taskModel,
      required this.userId,
      required this.parentContext});

  final TaskModel taskModel;
  final String userId;

  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: height * 0.11,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            DialogUtils.showMessage(context,
                message: LocaleKeys.sureToDelete.tr(),
                postActionName: LocaleKeys.delete.tr(), postAction: () async {
              DialogUtils.showLoadingDialog(context);
              await FireDataBase.deleteTask(taskModel.id ?? "", userId);

              DialogUtils.hideDialog(parentContext);
              DialogUtils.showMessage(
                parentContext,
                message: LocaleKeys.taskDeleted.tr(),
                postActionName: LocaleKeys.ok.tr(),
              );
            }, negActionName: LocaleKeys.cancel.tr());
          },
          direction: DismissDirection.startToEnd,
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.delete.tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.restore_from_trash_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                VerticalDivider(
                  width: 5,
                  color: taskModel.isDone
                      ? Colors.green
                      : Theme.of(context).colorScheme.primary,
                  thickness: 3,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      taskModel.title ?? "",
                      style: TextStyle(
                          color: taskModel.isDone
                              ? Colors.green
                              : Theme.of(context).colorScheme.primary,
                          fontSize: 20),
                    ),
                    Text(taskModel.desc ?? "")
                  ],
                ),
                Spacer(),
                if (!taskModel.isDone)
                  ElevatedButton(
                    onPressed: () async {
                      await FireDataBase.updateTask(
                          taskModel.id ?? "", userId, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Change this to your desired color
                    ),
                    child: Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                      // color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                if (taskModel.isDone)
                  Text(
                    LocaleKeys.taskDone.tr(),
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
