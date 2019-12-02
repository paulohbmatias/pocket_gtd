import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';

class ScheduledBloc extends BlocBase {
  final boxRepository = AppModule.to.getDependency<BoxRepository>();
  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  final _tasks = BehaviorSubject<List<TaskModel>>();

  Future<List<TaskModel>> getScheduledTasks() =>
      taskRepository.getAll(BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED));

  Observable<List<TaskModel>> get tasks => _tasks.stream;

  Function(List<TaskModel> tasks) get changeTasks => _tasks.sink.add;

  @override
  void dispose() {
    _tasks.close();
    super.dispose();
  }
}
