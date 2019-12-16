import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/next_actions/next_actions_bloc.dart';
import 'package:pocket_gtd/app/modules/next_actions/next_actions_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class NextActionsPage extends StatefulWidget {
  @override
  _NextActionsPageState createState() => _NextActionsPageState();
}

class _NextActionsPageState extends State<NextActionsPage> {

  final bloc = NextActionsModule.to.bloc<NextActionsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Stream<List<TaskModel>>>(
        future: bloc.getScheduledTasks(),
        builder: (context, snapshot) {
          return ListTasksModule(
              BoxModel.fromId(BoxModel.getIdFromEnum(InitialBoxesEnum.SCHEDULED)),
              ListTypeEnum.NEXT_ACTIONS,
              EmptyListWidget(
                I18n.of(context).app_pages_next_actions_empty_box,
                image: "assets/images/actions.png",
              ), streamListTasks: bloc.tasks,);
        }
      ),
    );
  }
}
