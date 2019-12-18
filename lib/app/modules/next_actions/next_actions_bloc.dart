import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';

class NextActionsBloc extends BlocBase {
  final boxRepository = AppModule.to.getDependency<BoxRepository>();
  final taskRepository = AppModule.to.getDependency<TaskRepository>();
  final box = BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED);

  List<TaskModel> listTasks = List();

  final _tasks = BehaviorSubject<List<TaskModel>>();
  final _scheduleTasks = BehaviorSubject<List<TaskModel>>();

  Observable<List<TaskModel>> get tasks => _tasks.stream.transform(StreamTransformer.fromHandlers(
    handleData: (list, sink){
      final now = DateTime.now();
      sink.add(list.where((item) =>
              (now.year == item.when.year) &&
              (now.month == item.when.month) &&
              (now.day == item.when.day))
          .toList());
    }
  ));
  Observable<List<TaskModel>> get scheduleTasks => _scheduleTasks.stream;

  Function(List<TaskModel> tasks) get changeTasks => _tasks.sink.add;
  Function(List<TaskModel> tasks) get changeScheduleTasks =>
      _scheduleTasks.sink.add;

  Future<Stream<List<TaskModel>>> getScheduledTasks() async {
    DateTime now = DateTime.now();
    listTasks = await taskRepository.getAll(box);
    changeTasks(await taskRepository.getAll(box));
    (await taskRepository.listenTasks(box)).listen((list){
      changeTasks(list
          .where((item) =>
              (now.year == item.when.year) &&
              (now.month == item.when.month) &&
              (now.day == item.when.day))
          .toList());
    });
    return tasks;
  }
  @override
  void dispose() {
    // _scheduleTasks.close();
    // _tasks.close();
    super.dispose();
  }
}
