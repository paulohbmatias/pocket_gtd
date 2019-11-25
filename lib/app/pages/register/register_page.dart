import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/register/widgets/register_box/register_box_widget.dart';
import 'package:pocket_gtd/app/pages/register/widgets/register_reference/register_reference_widget.dart';
import 'package:pocket_gtd/app/pages/register/widgets/register_task/register_task_widget.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';

class RegisterPage extends StatelessWidget {

  final ListTypeEnum type;

  const RegisterPage(this.type);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case ListTypeEnum.BOXES:
        return RegisterBoxWidget();
      case ListTypeEnum.REFERENCES:
        return RegisterReferenceWidget();
      default:
        return RegisterTaskWidget();
    }
  }
}
