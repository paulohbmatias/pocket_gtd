import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/pages/scheduled/scheduled_bloc.dart';
import 'package:pocket_gtd/app/pages/scheduled/scheduled_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduledPage extends StatefulWidget {
  const ScheduledPage({Key key}) : super(key: key);

  @override
  _ScheduledPageState createState() => _ScheduledPageState();
}

class _ScheduledPageState extends State<ScheduledPage> {
  final calendarController = CalendarController();
  final bloc = ScheduledModule.to.bloc<ScheduledBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder <
            Stream<List<TaskModel>>>(
              future: bloc.getScheduledTasks(),
              builder: (context, snapshot) {
                return StreamBuilder<List<TaskModel>>(
                    stream: snapshot.data,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Column(
                              children: <Widget>[
                                TableCalendar(
                                    calendarController: bloc.calendarTableController,
                                    events: Map<DateTime, List>.fromIterable(
                                        snapshot.data,
                                        key: (item) => item.when,
                                        value: (item) => snapshot.data
                                            .where((task) =>
                                                (task.when.year ==
                                                    item.when.year) &&
                                                (task.when.month ==
                                                    item.when.month) &&
                                                (task.when.day ==
                                                    item.when.day))
                                            .toList()),
                                    onDaySelected: (date, tasks) {
                                      if (tasks != null)
                                        bloc.changeScheduleTasks(tasks.isNotEmpty
                                            ? tasks as List<TaskModel>
                                            : <TaskModel>[]);
                                    },
                                    ),
                                Expanded(
                                  child: ListTasksModule(
                                      BoxModel.fromEnum(
                                          InitialBoxesEnum.SCHEDULED),
                                      ListTypeEnum.SCHEDULEDS,
                                      Container(),
                                      streamListTasks: bloc.scheduleTasks),
                                )
                              ],
                            )
                          : Container();
                    });
              },
            ));
  }
}
