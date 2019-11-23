import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class NextActionsPage extends StatefulWidget {
  @override
  _NextActionsPageState createState() => _NextActionsPageState();
}

class _NextActionsPageState extends State<NextActionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTasksModule(
          BoxModel(
              null, BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS), null, null),
          ListTypeEnum.NEXT_ACTIONS),
    );
  }
}
