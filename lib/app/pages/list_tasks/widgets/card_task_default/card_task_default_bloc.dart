import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/list_tasks/widgets/box_options/box_options_widget.dart';
import 'package:pocket_gtd/app/pages/register/register_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardTaskDefaultBloc extends BlocBase {

  final BoxModel box;

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
          title: Text(S.of(context).confirm_delete_task(task.title)),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  result = false;
                  Navigator.of(context).pop();
                },
                child: Text("No")),
            FlatButton(
                onPressed: () {
                  result = true;
                  Navigator.of(context).pop();
                },
                child: Text("Yes")),
          ],
        ));
    if(result){
      task.delete();
    }
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
