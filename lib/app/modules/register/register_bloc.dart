import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/priority_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BlocBase with RegisterValidators {
  final TaskModel task;
  final bool isUpdate;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final focusTitle = FocusNode();

  RegisterBloc({this.task, this.isUpdate = false}) {
    if (task != null) {
      changeTitle(task.title);
      changeDetails(task.details);
      changePriority(task.priority);
      detailsController.text = task.details;
      titleController.text = task.title;
      if (task.deadline != null) {
        changeDeadline(task.deadline);
      }
      if (task.when != null) {
        changeSchedule(task.when);
      }
    }
  }

  final TaskRepository taskRepository =
      AppModule.to.getDependency<TaskRepository>();
  final BoxRepository boxRepository =
      AppModule.to.getDependency<BoxRepository>();

  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _details = BehaviorSubject();
  BehaviorSubject<DateTime> _deadline = BehaviorSubject();
  BehaviorSubject<DateTime> _schedule = BehaviorSubject();
  BehaviorSubject<BoxModel> _box = BehaviorSubject();
  BehaviorSubject<bool> _isLoading = BehaviorSubject();
  BehaviorSubject<bool> _openDetails = BehaviorSubject();
  BehaviorSubject<PriorityEnum> _priority = BehaviorSubject.seeded(PriorityEnum.NORMAL);

  Observable<String> title(BuildContext context) =>
      _title.stream.transform(validateTitleFromStream(context));

  Observable<String> details(BuildContext context) =>
      _details.stream.transform(validateDescriptionFromStream(context));

  Observable<String> get deadline => _deadline.stream.transform(validateDate());
  Observable<String> get schedule => _schedule.stream.transform(validateDate());

  Observable<BoxModel> get box => _box.stream;

  Observable<bool> get isLoading => _isLoading.stream;

  Observable<bool> get openDetails => _openDetails.stream;

  Observable<PriorityEnum> get priority => _priority.stream;

  Observable<bool> isValidFields(BuildContext context) =>
      _title.transform(StreamTransformer<String, bool>.fromHandlers(
          handleData: (data, sink) {
        if (data != null &&
            validateDescriptionFromString(context, data).isEmpty) {
          sink.add(true);
        } else {
          sink.add(false);
        }
      }));

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDetails => _details.sink.add;
  Function(DateTime) get changeDeadline => _deadline.sink.add;
  Function(DateTime) get changeSchedule => _schedule.sink.add;
  Function(BoxModel) get changeBox => _box.sink.add;
  Function(bool) get changeIsLoading => _isLoading.sink.add;
  Function(bool) get changeOpenDetails => _openDetails.sink.add;
  Function(PriorityEnum) get changePriority => _priority.sink.add;

  Future<List<BoxModel>> getBoxes() async =>
      (await boxRepository.getAll()).where((box) {
        return box.idLocal != BoxModel.getIdFromEnum(InitialBoxesEnum.DONE) &&
            box.idLocal !=
                BoxModel.getIdFromEnum(InitialBoxesEnum.REFERENCES) &&
            box.idLocal != BoxModel.getIdFromEnum(InitialBoxesEnum.DONE);
      }).toList();

  void cancelDialog(BuildContext context) async {
    _cleanFields();
    Navigator.of(context).pop();
  }

  void saveTask(BuildContext context) async {
    changeIsLoading(true);
    try {
      TaskModel taskModel = TaskModel()
        ..title = _title.value
        ..details = _details.value
        ..deadline = _deadline.value
        ..when = _schedule.value
        ..priority = _priority.value;
      await taskRepository.save(
          taskModel,
          _box.value ??
              BoxModel.fromEnum(taskModel.when != null
                  ? InitialBoxesEnum.SCHEDULED
                  : InitialBoxesEnum.INBOX));
    } catch (e) {
      print(e);
    } finally {
      titleController.clear();
      detailsController.clear();
      _title.sink.add(null);
      _deadline.sink.add(null);
      _schedule.sink.add(null);
      _details.sink.add(null);
      _priority.sink.add(PriorityEnum.NORMAL);
      changeIsLoading(false);
      Fluttertoast.showToast(
          msg: I18n.of(context).successfully_added,
          backgroundColor: Colors.black87,
          fontSize: 15,
          toastLength: Toast.LENGTH_SHORT);
      focusTitle.requestFocus();
    }
  }

  void updateTask(BuildContext context) async {
    changeIsLoading(true);
    try {
      task.title = _title.value;
      task.details = _details.value;
      task.deadline = _deadline.value;
      task.when = _schedule.value;
      task.priority = _priority.value;
      await task.save();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  _cleanFields() {
    changeTitle("");
    changeDetails("");
  }

  @override
  void dispose() {
    _title.close();
    _details.close();
    _deadline.close();
    _box.close();
    _isLoading.close();
    _schedule.close();
    _openDetails.close();
    _priority.close();
    super.dispose();
  }
}
