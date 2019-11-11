import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/box_options/box_options_widget.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_module.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:rxdart/rxdart.dart';

class ListTasksBloc extends BlocBase {
  final BoxModel box;
  final ListTypeEnum listType;

  final TaskRepository taskRepository =
      AppModule.to.getDependency<TaskRepository>();

  List<TaskModel> listTasks = List();

  BehaviorSubject<List<TaskModel>> _tasks = BehaviorSubject();

  ListTasksBloc(this.box, this.listType);

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

  void edit(BuildContext context, TaskModel task) async {
    Navigator.of(context).pop();
    if (listType == ListTypeEnum.DEFAULT) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              RegisterModule(listType, task: task, isUpdate: true)));
    } else {
      showDialog(
          context: context,
          builder: (context) => RegisterModule(
                listType,
                task: task,
                isUpdate: true,
              ));
    }
  }

  Future<void> done(TaskModel task) async => await taskRepository.moveTask(
      box,
      BoxModel.fromMap(
          {'idLocal': BoxModel.getIdFromEnum(InitialBoxesEnum.DONE)}),
      task);

  Future<void> removeTask(TaskModel task) async {
    await taskRepository.delete(task, box);
  }

  Future<void> showOptionsBoxes(BuildContext context, TaskModel task) async {
    Navigator.of(context).pop();
    await showModalBottomSheet(
        context: context, builder: (context) => BoxOptionsWidget(task));
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
