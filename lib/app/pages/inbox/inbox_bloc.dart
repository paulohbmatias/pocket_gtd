import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_module.dart';

class InboxBloc extends BlocBase {

  void add(BuildContext context, ListTypeEnum type) async{
//    await showDialog(context: context, builder: (context) => RegisterModule(type));
    await Navigator.of(context).push(CupertinoPageRoute(builder: (context) => RegisterModule(type), maintainState: false));
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

}
  