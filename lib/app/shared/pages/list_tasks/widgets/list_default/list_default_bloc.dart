import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';

class ListDefaultBloc extends BlocBase {
  final BoxModel box;

  final TaskRepository taskRepository =
      AppModule.to.getDependency<TaskRepository>();

  List<TaskModel> listTasks = List();

  BehaviorSubject<List<TaskModel>> _tasks = BehaviorSubject();

  ListDefaultBloc(this.box);

  Observable<List<TaskModel>> get boxes => _tasks.stream;

  Function(List<TaskModel>) get changeBoxList => _tasks.sink.add;

  Future<List<TaskModel>> getTasks() => taskRepository.getAll(box);

  Future<Stream<List<TaskModel>>> listenTasks() async {
    listTasks = await taskRepository.getAll(box);
    changeBoxList(await taskRepository.getAll(box));
    (await taskRepository.listenTasks(box)).listen((list) {
      changeBoxList(list);
    });
    return boxes;
  }

  Future<void> done(TaskModel task) async => await taskRepository.moveTask(
      box,
      BoxModel.fromMap(
          {'idLocal': BoxModel.getIdFromEnum(InitialBoxesEnum.DONE)}),
      task);

  Future<void> removeTask(TaskModel task) async {
    await taskRepository.delete(task, box);
  }

  Future<void> undo(TaskModel task) async {
    await taskRepository.delete(
        task,
        BoxModel.fromMap(
            {'idLocal': BoxModel.getIdFromEnum(InitialBoxesEnum.DONE)}));
    await taskRepository.saveAt(task, box);
  }

  @override
  void dispose() {
    _tasks.close();
    super.dispose();
  }
}
