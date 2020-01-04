import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduledBloc extends BlocBase {
  final box = BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED);
  final taskRepository = AppModule.to.getDependency<TaskRepository>();
  StreamSubscription<List<TaskModel>> _tasksSubscription;

  final _tasks = BehaviorSubject<List<TaskModel>>();
  final _tasksDay = BehaviorSubject<List<TaskModel>>();
  List<TaskModel> list = List();

  final calendarTableController = CalendarController();

  Observable<List<TaskModel>> get tasksDay => _tasksDay.stream;

  Function(List<TaskModel>) get changeTasks => _tasksDay.sink.add;

  ScheduledBloc(){
    
  }

  Future<Stream<List<TaskModel>>> getTasks() async {
    try {
      final now = DateTime.now();
      _tasks.sink.add((await taskRepository.getAll(box))
          .where((item) =>
              (now.year == item.when.year) &&
              (now.month == item.when.month) &&
              (now.day == item.when.day))
          .toList());
      _tasksDay.sink.add((await taskRepository.getAll(box))
          .where((item) =>
              (now.year == item.when.year) &&
              (now.month == item.when.month) &&
              (now.day == item.when.day))
          .toList());
      _tasksSubscription = (await taskRepository.listenTasks(box)).listen(
          (data) {
            _tasks.sink.add(data
              .where((item) =>
                  (calendarTableController.selectedDay.year ==
                      item.when.year) &&
                  (calendarTableController.selectedDay.month ==
                      item.when.month) &&
                  (calendarTableController.selectedDay.day == item.when.day))
              .toList());
            _tasksDay.sink.add(data
              .where((item) =>
                  (calendarTableController.selectedDay.year ==
                      item.when.year) &&
                  (calendarTableController.selectedDay.month ==
                      item.when.month) &&
                  (calendarTableController.selectedDay.day == item.when.day))
              .toList());
          });
      return _tasks.stream;
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _tasks.close();
    _tasksDay.close();
    if (_tasksSubscription != null) _tasksSubscription.cancel();
    super.dispose();
  }
}
