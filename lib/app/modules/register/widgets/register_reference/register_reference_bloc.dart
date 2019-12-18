import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterReferenceBloc extends BlocBase with RegisterValidators {
  TaskRepository taskRepository = AppModule.to.getDependency<TaskRepository>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final TaskModel task;
  final bool isUpdate;

  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _content = BehaviorSubject();

  RegisterReferenceBloc({this.task, this.isUpdate = false}) {
    if (this.task != null) {
      contentController.text = task.content;
      changeContent(task.content);
    }
  }

  BehaviorSubject<bool> _isLoading = BehaviorSubject();

  Observable<String> title(BuildContext context) => _title.stream.transform(validateTitleFromStream(context));

  Observable<String> content(BuildContext context) => _content.stream.transform(validateDescriptionFromStream(context));

  Observable<bool> get isLoading => _isLoading.stream;

  Observable<bool> isValidFields(BuildContext context) =>
      Observable.combineLatest2<String, String, bool>(title(context), content(context), (email, password) {
        return validateTitleFromString(context, _title.value).isEmpty &&
                validateDescriptionFromString(context, _content.value).isEmpty
            ? true
            : false;
      });

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeContent => _content.sink.add;
  Function(bool) get changeIsLoading => _isLoading.sink.add;

  void cancelDialog(BuildContext context) async {
    _cleanFields();
    Navigator.of(context).pop();
  }

  void updateReference(BuildContext context) async {
    changeIsLoading(true);
    try {
      task.content = _content.value;
      await task.save();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      changeIsLoading(false);
    }
  }

  void saveReference(BuildContext context) async {
    changeIsLoading(true);
    try {
      TaskModel taskModel = TaskModel()
        ..content = _content.value;
      await taskRepository.save(
          taskModel, BoxModel.fromEnum(InitialBoxesEnum.REFERENCES));
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      changeIsLoading(false);
    }
  }

  _cleanFields() {
    changeTitle("");
    changeContent("");
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _title.close();
    _content.close();
    _isLoading.close();
    super.dispose();
  }
}
