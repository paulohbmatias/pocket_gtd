import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/pages/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/utils/date_utils.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardTaskDefaultWidget extends StatelessWidget {
  final TaskModel task;
  final ListTypeEnum listType;
  final bloc = ListTasksModule.to.bloc<CardTaskDefaultBloc>();

  CardTaskDefaultWidget(this.listType, this.task);

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
                    value: 4,
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
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                initialDatePickerMode: DatePickerMode.day,
                firstDate: DateTime.now().subtract(Duration(days: 1)),
                lastDate: DateTime(2060),
              );

              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              DateTime when = DateTime(
                  date.year, date.month, date.day, time.hour, time.minute);

              bloc.schedule(when, task);

              break;
            case 4:
              bloc.analyze(context, task);
              break;
            default:
              break;
          }
        }
      },
      onLongPress: (){},
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
                "${task.deadline.day} ${DateUtils.monthFromDate(task.deadline)}",
                style: TextStyle(
                    color: Color(0xffff7e67), fontWeight: FontWeight.bold),
              )
            : Text(""),
      ),
    );
  }
}
