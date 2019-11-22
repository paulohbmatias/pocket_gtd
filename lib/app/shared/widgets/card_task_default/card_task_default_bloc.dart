import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_module.dart';

class CardTaskDefaultBloc extends BlocBase {
  void edit(BuildContext context, ListTypeEnum type, TaskModel task) async {
    await Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => RegisterModule(
              type,
              isUpdate: true,
              task: task,
            ),
        maintainState: false));
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
