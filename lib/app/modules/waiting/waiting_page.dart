import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class WaitingPage extends StatefulWidget {
  final String title;
  const WaitingPage({Key key, this.title = "Waiting"}) : super(key: key);

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {

  @override
  Widget build(BuildContext context) {
    return ListTasksModule(
              ListTypeEnum.NEXT_ACTIONS,
              BoxModel.fromId(BoxModel.getIdFromEnum(InitialBoxesEnum.WAITING)),
              null,
              EmptyListWidget(
                I18n.of(context).app_pages_waiting_empty_box,
                image: "assets/images/wait.png",
              ));
  }
}
