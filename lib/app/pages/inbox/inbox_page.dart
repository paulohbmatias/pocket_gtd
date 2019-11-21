import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListTasksModule(
          BoxModel(null, BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX), null, null), ListTypeEnum.INBOX),
    );
  }
}
