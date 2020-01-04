import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/inbox/inbox_bloc.dart';
import 'package:pocket_gtd/app/modules/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final bloc = InboxModule.to.bloc<InboxBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Stream<List<TaskModel>>>(
          future: bloc.getTasks(),
          builder: (context, snapshot) {
            return snapshot.hasData ? StreamBuilder<List<TaskModel>>(
              stream: snapshot.data,
              builder: (context, snapshot) {
                return snapshot.hasData ? ListTasksModule(
                    ListTypeEnum.INBOX,
                    bloc.box,
                    snapshot.data,
                    EmptyListWidget(
                      I18n.of(context).app_pages_inbox_empty_box,
                      image: "assets/images/notes.png",
                    )) : Container();
              },
            ) : Container();
          }),
    );
  }
}
