import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/box_options/box_options_widget.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class ListTasksBloc extends BlocBase {
  final BoxModel box;
  final ListTypeEnum listType;
  final GlobalKey<ScaffoldState> scaffoldKey;
  Stream<List<TaskModel>> streamListTasks;

  final TaskRepository taskRepository =
      AppModule.to.getDependency<TaskRepository>();

  List<TaskModel> listTasks = List();

  BehaviorSubject<List<TaskModel>> _tasks = BehaviorSubject();

  ListTasksBloc(this.box, this.listType,
      {this.streamListTasks, this.scaffoldKey});

  Observable<List<TaskModel>> get tasks => _tasks.stream;

  Function(List<TaskModel>) get changeListTask => _tasks.sink.add;

  Future<List<TaskModel>> getTasks() => taskRepository.getAll(box);

  Future<Stream<List<TaskModel>>> listenTasks() async {
    if (streamListTasks != null) return streamListTasks;
    if (listType == ListTypeEnum.NEXT_ACTIONS) {
      listTasks = await taskRepository.getAll(box);
      changeListTask(await taskRepository.getAll(box));
      (await taskRepository.listenTasks(box)).listen((list) {
        changeListTask(list);
      });
    } else {
      listTasks = await taskRepository.getAll(box);
      changeListTask(await taskRepository.getAll(box));
      (await taskRepository.listenTasks(box)).listen((list) {
        changeListTask(list);
      });
    }
    return tasks;
  }

  void edit(BuildContext context, TaskModel task) async {
    showModalBottomSheet(
        context: context,
        elevation: 20,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (context) {
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: RegisterModule(
                listType,
                task: task,
                isUpdate: true,
              ));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
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

  void remove(BuildContext context, TaskModel task) async {
    bool result = false;
    result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(I18n.of(context).confirm_delete_task(task.content)),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("No")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Yes")),
              ],
            ));
    if (result) {
      task.delete();
    }
  }

  schedule(DateTime when, TaskModel task) {
    task.when = when;
    task.save();
    taskRepository.moveTask(
      BoxModel.fromEnum(InitialBoxesEnum.INBOX),
      BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED),
      task,
    );
  }

  markDone(BuildContext context, TaskModel task, bool value) {
    task.done = value;
    task.save();
    if (value && listType == ListTypeEnum.NEXT_ACTIONS) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: I18n.of(context).undo,
          onPressed: () {
            task.done = !value;
            task.save();
          },
        ),
        content: Text(I18n.of(context).done),
      ));
    }
  }

  moveTo(BuildContext context, TaskModel task, InitialBoxesEnum boxEnum) {
    taskRepository.moveTask(box, BoxModel.fromEnum(boxEnum), task);
  }

  void analyze(BuildContext context, TaskModel task) {
    showDialog(context: context, builder: (context) => AnalyzeModule(task));
  }

  Future<void> showOptionsBoxes(BuildContext context, TaskModel task) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BoxOptionsWidget(task),
      ),
    );
  }

  @override
  void dispose() {
    _tasks.close();
    super.dispose();
  }
}
