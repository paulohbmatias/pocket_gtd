import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/waiting/waiting_bloc.dart';
import 'package:pocket_gtd/app/modules/waiting/waiting_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class WaitingPage extends StatefulWidget {
  final String title;
  const WaitingPage({Key key, this.title = "Waiting"}) : super(key: key);

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {

  final bloc = WaitingModule.to.bloc<WaitingBloc>();
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
                  ListTypeEnum.ONE_DAY_MAYBE,
                  bloc.box,
                  snapshot.data,
                  EmptyListWidget(
                    I18n.of(context).app_pages_one_day_maybe_empty_box,
                    image: "assets/images/wait.png",
                  ), scaffoldKey: this.scaffoldKey,) : Container();
            }
          ) : Container();
        }
      ),
    );
  }
}
