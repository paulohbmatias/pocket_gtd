import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/references/references_bloc.dart';
import 'package:pocket_gtd/app/modules/references/references_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class ReferencesPage extends StatefulWidget {
  @override
  _ReferencesPageState createState() => _ReferencesPageState();
}

class _ReferencesPageState extends State<ReferencesPage> {
  final bloc = ReferencesModule.to.bloc<ReferencesBloc>();
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
                  ListTypeEnum.REFERENCES,
                  bloc.box,
                  snapshot.data,
                  EmptyListWidget(
                    I18n.of(context).app_pages_references_empty_box,
                    image: "assets/images/references.png",
                  ), scaffoldKey: this.scaffoldKey,) : Container();
            }
          ) : Container();
        }
      ),
    );
  }
}
