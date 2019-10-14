import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_module.dart';
import 'package:rxdart/rxdart.dart';

class AddOptionsBloc extends BlocBase {

  BehaviorSubject<bool> buttonOpen = BehaviorSubject();

  void add(BuildContext context, AddOptionsEnum type) async{
    buttonOpen.add(false);
    await showDialog(context: context, builder: (context) => RegisterModule(type));
  }

  @override
  void dispose() {
    buttonOpen.close();
    super.dispose();
  }
}
