import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/widgets/register_task/register_task_widget.dart';

class AddOptionsBloc extends BlocBase {

  void addTask(BuildContext context){
    showDialog(context: context, builder: (context) => RegisterTaskWidget());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
