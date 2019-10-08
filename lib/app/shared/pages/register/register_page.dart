import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_box/register_box_widget.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_reference/register_reference_widget.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_task/register_task_widget.dart';

class RegisterPage extends StatelessWidget {

  final AddOptionsEnum type;

  const RegisterPage(this.type);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case AddOptionsEnum.TASK:
        return RegisterTaskWidget();
      case AddOptionsEnum.BOX:
        return RegisterBoxWidget();
      case AddOptionsEnum.REFERENCE:
        return RegisterReferenceWidget();
      default:
        return Container();
    }
  }
}
