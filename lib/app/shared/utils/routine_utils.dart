import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/routine_often_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/routine_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class RoutineUtils {
  final _routineRepository = AppModule.to.getDependency<RoutineRepository>();
  final _taskRepository = AppModule.to.getDependency<TaskRepository>();

  addRoutines() async {
    final routines = await _routineRepository.getAll();
    for (RoutineModel routine in routines) {
      if (routine.isActive) {
        if (routine.routineOften == RoutineOftenEnum.DAY) {
          if (routine.lastAdded == null) {
            int difference = routine.begin
                .difference(DateTime.now().add(Duration(hours: 1)))
                .inDays;
            if (difference < 0 ||
                (difference == 0 && routine.begin.day == DateTime.now().day)) {
              final task = TaskModel()
                ..title = routine.title
                ..details = routine.details
                ..deadline = DateTime.now()
                ..when = DateTime.now();

              _taskRepository.save(
                  task, BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED));
              routine.lastAdded = DateTime.now();
              routine.save();
            }
          } else {
            int i = routine.lastAdded.difference(DateTime.now()).inDays;
            if (routine.lastAdded.difference(DateTime.now()).inDays <=
                (routine.often * -1)) {
              final task = TaskModel()
                ..title = routine.title
                ..details = routine.details
                ..deadline = DateTime.now()
                ..when = DateTime.now();
              _taskRepository.save(
                  task, BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED));
              routine.lastAdded = DateTime.now();
              routine.save();
            }
          }
        } else if (routine.routineOften == RoutineOftenEnum.WEEK) {
          if (routine.lastAdded == null) {
            int difference = routine.begin
                .difference(DateTime.now().add(Duration(hours: 1)))
                .inDays;
            if (difference < 0 ||
                (difference == 0 && routine.begin.day == DateTime.now().day)) {
              final task = TaskModel()
                ..title = routine.title
                ..details = routine.details
                ..deadline = DateTime.now()
                ..when = DateTime.now();
              _taskRepository.save(
                  task, BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED));
              routine.lastAdded = DateTime.now();
              routine.save();
            }
          } else {
            int difference = routine.lastAdded
                .difference(DateTime.now().add(Duration(hours: 1)))
                .inDays;
            if (routine.daysOfWeek.contains(DateTime.now().weekday) &&
                (difference < 0 ||
                    (difference == 0 &&
                        routine.lastAdded.day != DateTime.now().day)) &&
                difference >=
                    (((routine.often * 7) +
                            routine.daysOfWeek
                                .reduce((v1, v2) => v1 >= v2 ? v1 : v2)) *
                        -1)) {
              final task = TaskModel()
                ..title = routine.title
                ..details = routine.details
                ..deadline = DateTime.now()
                ..when = DateTime.now();
              _taskRepository.save(
                  task, BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED));
              routine.lastAdded = DateTime.now();
              routine.save();
            }
          }
        }
      }
    }
  }
}
