import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/mixins/card_task_mixin.dart';
import 'package:pocket_gtd/app/modules/list_tasks/models/item_menu_task_model.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/models/user_model.dart';
import 'package:pocket_gtd/app/shared/widgets/delegate/delegate_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardTaskDefaultWidget extends StatelessWidget with CardTaskMixin {
  final TaskModel task;
  final BoxModel box;
  final ListTypeEnum listType;
  final bool hasCheckBox;
  GlobalKey<ScaffoldState> scaffoldKey;

  final bloc = ListTasksModule.to.bloc<ListTasksBloc>();

  CardTaskDefaultWidget(
    this.listType,
    this.box,
    this.task, {
    this.hasCheckBox = false,
    this.scaffoldKey
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTapDown: (pos) async {
          int result = await showOptions(
            context,
            RelativeRect.fromLTRB(
              pos.globalPosition.dx,
              pos.globalPosition.dy,
              pos.globalPosition.dx,
              pos.globalPosition.dy,
            ),
            <ItemMenuTaskModel>[
              ItemMenuTaskModel(0, OMIcons.edit, I18n.of(context).edit),
              ItemMenuTaskModel(1, OMIcons.delete, I18n.of(context).remove),
              ItemMenuTaskModel(2, OMIcons.arrowForward, I18n.of(context).move),
              listType == ListTypeEnum.INBOX
                  ? ItemMenuTaskModel(3, OMIcons.permContactCalendar,
                      I18n.of(context).delegate_task)
                  : null,
              listType == ListTypeEnum.INBOX
                  ? ItemMenuTaskModel(
                      4, OMIcons.eventNote, I18n.of(context).schedule)
                  : null,
              listType == ListTypeEnum.INBOX
                  ? ItemMenuTaskModel(
                      5, OMIcons.reorder, I18n.of(context).analyze)
                  : null,
            ],
          );
          if (result != null) {
            switch (result) {
              case 0:
                bloc.edit(context, listType, task);
                break;
              case 1:
                bloc.remove(context, task);
                break;
              case 2:
                bloc.showOptionsBoxes(context, task, box);
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
                  bloc.moveTo(
                      context, task, box.boxEnum, InitialBoxesEnum.WAITING);
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
        onLongPress: () {

        },
        child: hasCheckBox
            ? CheckboxListTile(
                value: task.done,
                onChanged: (value) =>
                    bloc.markDone(context, task, value, listType, scaffoldKey: scaffoldKey),
                selected: task.done,
                activeColor: Colors.grey[400],
                title: Text(
                  task.content,
                  style: TextStyle(
                      decoration: task.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                subtitle: task.deadline != null
                    ? Text(
                        dateTask(context, task),
                        style: TextStyle(
                            color:
                                !task.done ? Color(0xffff7e67) : Colors.grey[400],
                            decoration: task.done
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(""),
              )
            : ListTile(
                contentPadding: EdgeInsets.all(8),
                title: Text(task.content),
                leading: Icon(
                  MdiIcons.noteTextOutline,
                  size: 35,
                ),
                subtitle: task.deadline != null
                    ? Text(
                        dateTask(context, task),
                        style: TextStyle(
                            color: Color(0xffff7e67),
                            fontWeight: FontWeight.bold),
                      )
                    : Text(""),
              ),
      ),
    );
  }
}
