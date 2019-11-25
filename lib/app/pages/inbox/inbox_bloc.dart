import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/register/register_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';

class InboxBloc extends BlocBase {

  void add(BuildContext context, ListTypeEnum type) async{
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => RegisterModule(type)
    ));
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

}
  