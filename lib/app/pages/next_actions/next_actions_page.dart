import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
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
          BoxModel.fromId(BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS)),
          ListTypeEnum.NEXT_ACTIONS,
          EmptyListWidget(
            S.of(context).app_pages_next_actions_empty_box,
            image: "assets/images/actions.png",
          )),
    );
  }
}
