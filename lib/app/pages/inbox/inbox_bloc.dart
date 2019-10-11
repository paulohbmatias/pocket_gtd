import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_module.dart';

class InboxBloc extends BlocBase {

  void add(BuildContext context, AddOptionsEnum type){
    showDialog(context: context, builder: (context) => RegisterModule(type));
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

}
  