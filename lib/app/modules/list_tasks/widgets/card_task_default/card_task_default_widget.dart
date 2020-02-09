import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/mixins/card_task_mixin.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/item_menu_task_model.dart';
import 'package:pocket_gtd/app/shared/models/priority_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/models/user_model.dart';
import 'package:pocket_gtd/app/shared/widgets/delegate/delegate_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardTaskDefaultWidget extends StatelessWidget with CardMixin {
  final TaskModel task;
  final BoxModel box;
  final ListTypeEnum listType;
  final bool hasCheckBox;
  GlobalKey<ScaffoldState> scaffoldKey;

  final bloc = ListTasksModule.to.bloc<ListTasksBloc>();

  CardTaskDefaultWidget(this.listType, this.box, this.task,
      {this.hasCheckBox = false, this.scaffoldKey});

  Widget priorityWidget(BuildContext context, PriorityEnum priorityEnum) {
    switch (priorityEnum) {
      case PriorityEnum.LOW:
        return Icon(
          OMIcons.keyboardArrowDown,
          size: 16,
          color: Colors.blueAccent,
        );
      case PriorityEnum.NORMAL:
        return Icon(
          Icons.drag_handle,
          size: 16,
          color: Colors.yellow[800],
        );
      case PriorityEnum.HIGH:
        return Icon(
          OMIcons.keyboardArrowUp,
          size: 16,
          color: Colors.redAccent,
        );
      case PriorityEnum.URGENT:
        return RotatedBox(
          quarterTurns: 3,
          child: SvgPicture.asset(
            "assets/icons/double_arrow.svg",
            height: 12,
            color: Colors.red,
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: () {},
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
                ItemMenuTaskModel(
                    2, OMIcons.arrowForward, I18n.of(context).move),
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
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(8),
                isThreeLine: false,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                              decoration: task.done
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      ),
                      listType == ListTypeEnum.REFERENCES ||
                              listType == ListTypeEnum.ONE_DAY_MAYBE
                          ? Container()
                          : Container(
                              // margin: const EdgeInsets.all(8),
                              child: priorityWidget(context, task.priority),
                            ),
                    ],
                  ),
                ),
                leading: hasCheckBox
                    ? CircularCheckBox(
                        value: task.done,

                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) => bloc.markDone(
                            context, task, value, listType,
                            scaffoldKey: scaffoldKey),
                        // activeColor: Colors.grey[400],
                      )
                    : null,
                subtitle: task.details != null || task.deadline != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          task.details != null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(task.details),
                                )
                              : Container(),
                          task.deadline != null
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  // padding: const EdgeInsets.all(value),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Chip(
                                      label: Text(
                                        dateTask(context, task),
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      avatar: Icon(
                                        MdiIcons.calendarCheck,
                                        size: 14,
                                        color: !task.deadline
                                                .isBefore(DateTime.now())
                                            ? Theme.of(context).primaryColor
                                            : Colors.redAccent,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: Colors.grey, width: .5),
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ))
                              : Container(),
                        ],
                      )
                    : null,
              ),
              Divider()
            ],
          )),
    );
  }
}
