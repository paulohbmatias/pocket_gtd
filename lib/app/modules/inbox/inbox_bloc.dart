import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';

class InboxBloc extends BlocBase {
  void add(BuildContext context, ListTypeEnum type) async {
    // await Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => RegisterModule(type)
    // ));
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return RegisterModule(type);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      )
    );
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
