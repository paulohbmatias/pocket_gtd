import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/models/user_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';

class DelegateBloc extends BlocBase {
  final TaskModel task;
  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  BehaviorSubject<String> _name = BehaviorSubject();

  Function(String) get changeName => _name.sink.add;

  Observable<bool> get isEmpty =>
      _name.stream.transform(StreamTransformer<String, bool>.fromHandlers(
          handleData: (data, sink) => sink.add(data.isEmpty)));

  DelegateBloc(this.task);

  done() {
    try {
      task.who = UserModel()..name = _name.value;
      task.save();
      taskRepository.moveTask(
        BoxModel.fromEnum(InitialBoxesEnum.INBOX),
        BoxModel.fromEnum(InitialBoxesEnum.WAITING),
        task,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _name.close();
    super.dispose();
  }
}
