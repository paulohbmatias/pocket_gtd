import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';

class ReferencesPage extends StatefulWidget {
  @override
  _ReferencesPageState createState() => _ReferencesPageState();
}

class _ReferencesPageState extends State<ReferencesPage> {
  @override
  Widget build(BuildContext context) {
    return ListTasksModule(
        BoxModel.fromId(BoxModel.getIdFromEnum(InitialBoxesEnum.REFERENCES)),
        ListTypeEnum.REFERENCES, Container());
  }
}
