import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/box_options/box_options_widget.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_module.dart';

class CardTaskDefaultBloc extends BlocBase {

  void edit(BuildContext context, ListTypeEnum type, TaskModel task) async{
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => RegisterModule(type, isUpdate: true, task: task,)
    ));
  }

  Future<void> showOptionsBoxes(BuildContext context, TaskModel task) async {
    Navigator.of(context).pop();
    await showModalBottomSheet(
        context: context, builder: (context) => BoxOptionsWidget(task));
  }
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

}
  