import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/add_options/add_options_widget.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddOptionsWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: ListTasksModule(
          BoxModel(
              null, BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX), null, null),
          ListTypeEnum.INBOX),
    );
  }
}
