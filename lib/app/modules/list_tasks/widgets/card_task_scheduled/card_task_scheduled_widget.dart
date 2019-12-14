import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_scheduled/card_task_scheduled_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/delegate/delegate_widget.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/models/user_model.dart';
import 'package:pocket_gtd/app/shared/utils/date_utils.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardTaskScheduledWidget extends StatelessWidget {
  final TaskModel task;
  final ListTypeEnum listType;
  final bloc = ListTasksModule.to.bloc<CardTaskScheduledBloc>();

  CardTaskScheduledWidget(this.listType, this.task);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (pos) async {
        int result = await showMenu<int>(
          context: context,
          position: RelativeRect.fromLTRB(
            pos.globalPosition.dx,
            pos.globalPosition.dy,
            pos.globalPosition.dx,
            pos.globalPosition.dy,
          ),
          items: <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: <Widget>[
                  Icon(OMIcons.edit),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(I18n.of(context).edit),
                  ),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: <Widget>[
                  Icon(OMIcons.delete),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(I18n.of(context).remove),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: <Widget>[
                  Icon(OMIcons.arrowForward),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(I18n.of(context).move),
                  ),
                ],
              ),
            ),
            bloc.box.idLocal == BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX)
                ? PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: <Widget>[
                        Icon(OMIcons.permContactCalendar),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(I18n.of(context).delegate_task),
                        ),
                      ],
                    ),
                  )
                : null,
            bloc.box.idLocal == BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX)
                ? PopupMenuItem(
                    value: 4,
                    child: Row(
                      children: <Widget>[
                        Icon(OMIcons.eventNote),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(I18n.of(context).schedule),
                        ),
                      ],
                    ),
                  )
                : null,
            bloc.box.idLocal == BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX)
                ? PopupMenuItem(
                    value: 5,
                    child: Row(
                      children: <Widget>[
                        Icon(OMIcons.reorder),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(I18n.of(context).analyze),
                        ),
                      ],
                    ),
                  )
                : null,
          ],
        );
        if (result != null) {
          switch (result) {
            case 0:
              bloc.edit(context, ListTypeEnum.DEFAULT, task);
              break;
            case 1:
              bloc.remove(context, task);
              break;
            case 2:
              bloc.showOptionsBoxes(context, task);
              break;
            case 3:
              final result = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    return DelegateWidget();
                  });
              if (result != null && result.isNotEmpty) {
                task.who = UserModel()..name = result;
                task.save();
                bloc.moveTo(context, task, InitialBoxesEnum.WAITING);
              }
              break;
            case 4:
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                initialDatePickerMode: DatePickerMode.day,
                firstDate: DateTime.now().subtract(Duration(days: 1)),
                lastDate: DateTime(2060),
              );
              if (date == null) return;
              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              DateTime when = DateTime(
                  date.year, date.month, date.day, time.hour, time.minute);

              bloc.schedule(when, task);

              break;
            case 5:
              bloc.analyze(context, task);
              break;
            default:
              break;
          }
        }
      },
      onLongPress: () {},
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        title: Text(task.title),
        subtitle: Text(task.content),
        leading: Icon(
          MdiIcons.noteTextOutline,
          size: 35,
        ),
        trailing: task.deadline != null
            ? Text(
                dateTask(context),
                style: TextStyle(
                    color: Color(0xffff7e67), fontWeight: FontWeight.bold),
              )
            : Text(""),
      ),
    );
  }

  String dateTask(BuildContext context) {
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
