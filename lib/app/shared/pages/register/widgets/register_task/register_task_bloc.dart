import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterTaskBloc extends BlocBase with RegisterValidators {
  final TaskModel task;

  RegisterTaskBloc({this.task}) {
    if (task != null) {
      changeTitle(task.title);
      changeDescription(task.content);
      changeDeadline(task.deadline);
    }
  }

  final TaskRepository taskRepository =
      AppModule.to.getDependency<TaskRepository>();
  final BoxRepository boxRepository =
      AppModule.to.getDependency<BoxRepository>();

  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _description = BehaviorSubject();
  BehaviorSubject<DateTime> _deadline = BehaviorSubject();
  BehaviorSubject<BoxModel> _box = BehaviorSubject();
  BehaviorSubject<bool> _isLoading = BehaviorSubject();

  Observable<String> title(BuildContext context) =>
      _title.stream.transform(validateTitleFromStream(context));

  Observable<String> description(BuildContext context) =>
      _description.stream.transform(validateDescriptionFromStream(context));

  Observable<String> get deadline => _deadline.stream.transform(validateDate());

  Observable<BoxModel> get box => _box.stream;

  Observable<bool> get isLoading => _isLoading.stream;

  Observable<bool> isValidFields(BuildContext context) =>
      Observable.combineLatest2<String, String, bool>(
          title(context), description(context), (email, password) {
        return validateTitleFromString(context, _title.value).isEmpty &&
                validateDescriptionFromString(context, _description.value)
                    .isEmpty
            ? true
            : false;
      });

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(DateTime) get changeDeadline => _deadline.sink.add;
  Function(BoxModel) get changeBox => _box.sink.add;
  Function(bool) get changeIsLoading => _isLoading.sink.add;

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
      TaskModel taskModel = TaskModel(
          null, null, _title.value, _description.value, _deadline.value);
      await taskRepository.save(
          taskModel,
          _box.value ??
              BoxModel(null, BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX),
                  null, null));
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      changeIsLoading(false);
    }
  }

  void updateTask(BuildContext context) async {
    changeIsLoading(true);
    try {
      task.title = _title.value;
      task.content = _description.value;
      task.deadline = _deadline.value;
      await task.save();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      changeIsLoading(false);
    }
  }

  _cleanFields() {
    changeTitle("");
    changeDescription("");
  }

  @override
  void dispose() {
    _title.close();
    _description.close();
    _deadline.close();
    _box.close();
    _isLoading.close();
    super.dispose();
  }
}
