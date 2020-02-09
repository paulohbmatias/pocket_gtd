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
            if (routine.begin.difference(DateTime.now()).inDays <= 0) {
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
                routine.often) {
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
            if (routine.begin.difference(DateTime.now()).inDays <= 0) {
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
            if (routine.daysOfWeek.contains(DateTime.now().weekday) &&
                routine.lastAdded.difference(DateTime.now()).inDays != 0) {
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
