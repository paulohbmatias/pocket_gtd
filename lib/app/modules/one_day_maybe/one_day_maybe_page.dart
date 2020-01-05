import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/one_day_maybe/one_day_maybe_bloc.dart';
import 'package:pocket_gtd/app/modules/one_day_maybe/one_day_maybe_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class OneDayMaybePage extends StatefulWidget {
  final String title;
  const OneDayMaybePage({Key key, this.title = "OneDayMaybe"})
      : super(key: key);

  @override
  _OneDayMaybePageState createState() => _OneDayMaybePageState();
}

class _OneDayMaybePageState extends State<OneDayMaybePage> {
  final bloc = OneDayMaybeModule.to.bloc<OneDayMaybeBloc>();
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
                    image: "assets/images/one_day_maybe.png",
                  ), scaffoldKey: this.scaffoldKey,) : Container();
            }
          ) : Container();
        }
      ),
    );
  }
}
