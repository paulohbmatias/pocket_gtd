import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class RegisterTaskBloc extends BlocBase with RegisterValidators {
  final TaskModel task;
  final bool isUpdate;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  RegisterTaskBloc({this.task, this.isUpdate = false}) {
    if (task != null) {
      changeTitle(task.title);
      titleController.text = task.title;
      changeDescription(task.content);
      contentController.text = task.content;
      if (task.deadline != null) {
        changeDeadline(task.deadline);
      }
      if (task.when != null) {
        changeSchedule(task.when);
      }
    }
  }

  final TaskRepository taskRepository = AppModule.to.getDependency<TaskRepository>();
  final BoxRepository boxRepository = AppModule.to.getDependency<BoxRepository>();

  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _description = BehaviorSubject();
  BehaviorSubject<DateTime> _deadline = BehaviorSubject();
  BehaviorSubject<DateTime> _schedule = BehaviorSubject();
  BehaviorSubject<BoxModel> _box = BehaviorSubject();
  BehaviorSubject<bool> _isLoading = BehaviorSubject();

  Observable<String> title(BuildContext context) => _title.stream.transform(validateTitleFromStream(context));

  Observable<String> description(BuildContext context) =>
      _description.stream.transform(validateDescriptionFromStream(context));

  Observable<String> get deadline => _deadline.stream.transform(validateDate());
  Observable<String> get schedule => _schedule.stream.transform(validateDate());

  Observable<BoxModel> get box => _box.stream;

  Observable<bool> get isLoading => _isLoading.stream;

  Observable<bool> isValidFields(BuildContext context) =>
      Observable.combineLatest2<String, String, bool>(title(context), description(context), (title, description) {
        print(title);
        return validateTitleFromString(context, _title.value).isEmpty &&
                validateDescriptionFromString(context, _description.value).isEmpty
            ? true
            : false;
      });

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(DateTime) get changeDeadline => _deadline.sink.add;
  Function(DateTime) get changeSchedule => _schedule.sink.add;
  Function(BoxModel) get changeBox => _box.sink.add;
  Function(bool) get changeIsLoading => _isLoading.sink.add;

  Future<List<BoxModel>> getBoxes() async => (await boxRepository.getAll()).where((box) {
        return box.idLocal != BoxModel.getIdFromEnum(InitialBoxesEnum.DONE) &&
            box.idLocal != BoxModel.getIdFromEnum(InitialBoxesEnum.REFERENCES) &&
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
        ..content = _description.value
        ..deadline = _deadline.value
        ..when = _schedule.value;
      await taskRepository.save(
          taskModel, _box.value ?? BoxModel.fromEnum(taskModel.when != null ? InitialBoxesEnum.SCHEDULED : InitialBoxesEnum.INBOX));
    } catch (e) {
      print(e);
    } finally {
      titleController.clear();
      contentController.clear();
      _title.sink.add(null);
      _description.sink.add(null);
      changeIsLoading(false);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(I18n.of(context).successfully_added),
      ));
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
    _schedule.close();
    super.dispose();
  }
}
