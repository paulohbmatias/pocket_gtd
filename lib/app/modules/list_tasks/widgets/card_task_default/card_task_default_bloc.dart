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

class CardTaskDefaultBloc extends BlocBase {

  final BoxModel box;

  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  CardTaskDefaultBloc(this.box);
  
  void edit(BuildContext context, ListTypeEnum type, TaskModel task) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterModule(
                  type,
                  isUpdate: true,
                  task: task,
                )));
  }

  void remove(BuildContext context, TaskModel task) async{
    bool result = false;
    result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(I18n.of(context).confirm_delete_task(task.title)),
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
    if(result){
      task.delete();
    }
  }

  schedule(DateTime when, TaskModel task){
    task.when = when;
    task.save();
    taskRepository.moveTask(
      BoxModel.fromEnum(InitialBoxesEnum.INBOX),
      BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED),
      task,
    );
  }

  void analyze(BuildContext context, TaskModel task){
    showDialog(context: context, builder: (context) => AnalyzeModule(task));
  }

  Future<void> showOptionsBoxes(BuildContext context, TaskModel task) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BoxOptionsWidget(task),
      ),
    );
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
