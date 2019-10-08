import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/pages/register_task/register_task_module.dart';

class AddOptionsBloc extends BlocBase {

  void addTask(BuildContext context){
    showDialog(context: context, builder: (context) => RegisterTaskModule());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
