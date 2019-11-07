import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_box/register_box_widget.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_reference/register_reference_widget.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_task/register_task_widget.dart';

class RegisterPage extends StatelessWidget {

  final ListTypeEnum type;

  const RegisterPage(this.type);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case ListTypeEnum.DEFAULT:
        return RegisterTaskWidget();
      case ListTypeEnum.BOXES:
        return RegisterBoxWidget();
      case ListTypeEnum.REFERENCES:
        return RegisterReferenceWidget();
      default:
        return Container();
    }
  }
}
