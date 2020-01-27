import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/scheduled/scheduled_bloc.dart';
import 'package:pocket_gtd/app/modules/scheduled/scheduled_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: Text(
              I18n.of(context).scheduled,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          body: FutureBuilder<Stream<List<TaskModel>>>(
            future: bloc.getTasks(),
            builder: (context, snapshot) {
              return StreamBuilder<List<TaskModel>>(
                  stream: snapshot.data,
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    return snapshot.hasData
                        ? Column(
                            children: <Widget>[
                              TableCalendar(
                                calendarController:
                                    bloc.calendarTableController,
                                initialSelectedDay: DateTime.now(),
                                events: Map<DateTime, List>.fromIterable(
                                    snapshot.data,
                                    key: (item) => item.when,
                                    value: (item) => snapshot.data
                                        .where((task) =>
                                            (task.when.year ==
                                                item.when.year) &&
                                            (task.when.month ==
                                                item.when.month) &&
                                            (task.when.day == item.when.day))
                                        .toList()),
                                onDaySelected: (date, tasks) {
                                  if (tasks != null)
                                    bloc.changeTasks(tasks.isNotEmpty
                                        ? tasks as List<TaskModel>
                                        : <TaskModel>[]);
                                },
                                formatAnimation: FormatAnimation.slide,
                                availableCalendarFormats: {
                                  CalendarFormat.month:
                                      I18n.of(context).month_calendar,
                                  CalendarFormat.week:
                                      I18n.of(context).week_calendar,
                                  CalendarFormat.twoWeeks:
                                      I18n.of(context).two_weeks
                                },
                                initialCalendarFormat: CalendarFormat.twoWeeks,
                                calendarStyle: CalendarStyle(
                                  canEventMarkersOverflow: true,
                                  markersMaxAmount: 1,
                                  markersColor: Theme.of(context).accentColor,
                                  renderDaysOfWeek: true,
                                  selectedColor: Theme.of(context).primaryColor,
                                ),
                                
                                headerStyle: HeaderStyle(
                                    centerHeaderTitle: true,
                                    formatButtonShowsNext: false,
                                    formatButtonVisible: false),
                              ),
                              Expanded(
                                child: StreamBuilder<List<TaskModel>>(
                                    stream: bloc.tasksDay,
                                    initialData: [],
                                    builder: (context, snapshot) {
                                      return ListTasksModule(
                                          ListTypeEnum.SCHEDULEDS,
                                          BoxModel.fromEnum(
                                              InitialBoxesEnum.SCHEDULED),
                                          snapshot.data,
                                          Container());
                                    }),
                              )
                            ],
                          )
                        : Container();
                  });
            },
          )),
    );
  }
}
