import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduledBloc extends BlocBase {
  final boxRepository = AppModule.to.getDependency<BoxRepository>();
  final taskRepository = AppModule.to.getDependency<TaskRepository>();
  final box = BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED);
  List<TaskModel> listTasks = List();

  final calendarTableController = CalendarController();

  final _tasks = BehaviorSubject<List<TaskModel>>();
  final _scheduleTasks = BehaviorSubject<List<TaskModel>>();

  Observable<List<TaskModel>> get tasks => _tasks.stream;
  Observable<List<TaskModel>> get scheduleTasks => _scheduleTasks.stream;

  Function(List<TaskModel> tasks) get changeTasks => _tasks.sink.add;
  Function(List<TaskModel> tasks) get changeScheduleTasks =>
      _scheduleTasks.sink.add;

  Future<Stream<List<TaskModel>>> getScheduledTasks() async {
    DateTime now = DateTime.now();
    listTasks = await taskRepository.getAll(box);
    changeTasks(await taskRepository.getAll(box));
    changeScheduleTasks(listTasks
          .where((item) =>
              (now.year == item.when.year) &&
              (now.month == item.when.month) &&
              (now.day == item.when.day))
          .toList());
    (await taskRepository.listenTasks(box)).listen((list) {
      changeScheduleTasks(list
          .where((item) =>
              (calendarTableController.selectedDay.year == item.when.year) &&
              (calendarTableController.selectedDay.month == item.when.month) &&
              (calendarTableController.selectedDay.day == item.when.day))
          .toList());
      changeTasks(list);
    });
    return tasks;
  }

  @override
  void dispose() {
    _tasks.close();
    _scheduleTasks.close();
    super.dispose();
  }
}
