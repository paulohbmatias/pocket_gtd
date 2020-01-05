import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';

class NextActionsBloc extends BlocBase {
  final box = BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED);
  final taskRepository = AppModule.to.getDependency<TaskRepository>();
  StreamSubscription<List<TaskModel>> _tasksSubscription;

  final _tasks = BehaviorSubject<List<TaskModel>>();

  Future<Stream<List<TaskModel>>> getTasks() async {
    final now = DateTime.now();
    _tasks.sink.add((await taskRepository.getAll(box))
        .where((item) =>
            (now.year == item.when.year) &&
            (now.month == item.when.month) &&
            (now.day == item.when.day) &&
            !item.done)
        .toList());
    _tasksSubscription = (await taskRepository.listenTasks(box)).listen(
        (data) => _tasks.sink.add(data
            .where((item) =>
                (now.year == item.when.year) &&
                (now.month == item.when.month) &&
                (now.day == item.when.day) &&
                !item.done)
            .toList()));
    return _tasks.stream;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _tasks.close();
    if (_tasksSubscription != null) _tasksSubscription.cancel();
    super.dispose();
  }
}
