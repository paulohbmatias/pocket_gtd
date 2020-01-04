import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/next_actions/next_actions_bloc.dart';
import 'package:pocket_gtd/app/modules/next_actions/next_actions_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class NextActionsPage extends StatefulWidget {
  @override
  _NextActionsPageState createState() => _NextActionsPageState();
}

class _NextActionsPageState extends State<NextActionsPage> {

  final bloc = NextActionsModule.to.bloc<NextActionsBloc>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: FutureBuilder<Stream<List<TaskModel>>>(
        future: bloc.getTasks(),
        builder: (context, snapshot) {
          return snapshot.hasData ? StreamBuilder<List<TaskModel>>(
            stream: snapshot.data,
            builder: (context, snapshot) {
              print(snapshot.data);
              return snapshot.hasData ? ListTasksModule(
                  ListTypeEnum.NEXT_ACTIONS,
                  bloc.box,
                  snapshot.data,
                  EmptyListWidget(
                    I18n.of(context).app_pages_next_actions_empty_box,
                    image: "assets/images/actions.png",
                  ), scaffoldKey: this.scaffoldKey,) : Container();
            }
          ) : Container();
        }
      ),
    );
  }
}
