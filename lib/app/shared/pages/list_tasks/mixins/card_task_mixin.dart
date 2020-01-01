import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/models/item_menu_task_model.dart';
import 'package:pocket_gtd/app/shared/utils/date_utils.dart';
import 'package:pocket_gtd/generated/i18n.dart';

mixin CardTaskMixin{
  Future<int> showOptions(BuildContext context, RelativeRect position, List<ItemMenuTaskModel> items){
    return showMenu<int>(
      context: context,
      position: position,
      items: items.map<PopupMenuEntry<int>>((item){
        return PopupMenuItem<int>(
              value: item.value,
              child: Row(
                children: <Widget>[
                  Icon(item.icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.text),
                  ),
                ],
              ),
            );
      }).toList()
    );
  }

  String dateTask(BuildContext context, TaskModel task) {
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    if ((task.deadline.year == today.year) &&
        (task.deadline.month == today.month) &&
        (task.deadline.day == today.day)) {
      return I18n.of(context).today;
    } else if ((task.deadline.year == tomorrow.year) &&
        (task.deadline.month == tomorrow.month) &&
        (task.deadline.day == tomorrow.day)) {
      return I18n.of(context).tomorrow;
    } else {
      return "${task.deadline.day} ${DateUtils.monthFromDate(task.deadline)}";
    }
  }
}