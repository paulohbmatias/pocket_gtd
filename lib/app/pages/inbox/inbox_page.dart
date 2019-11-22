import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_bloc.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final bloc = InboxModule.to.bloc<InboxBloc>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: true,
        trailing: CupertinoButton(
            padding: const EdgeInsets.all(8),
            onPressed: () => bloc.add(context, ListTypeEnum.DEFAULT),
            child: Icon(CupertinoIcons.add)),
      ),
      child: ListTasksModule(
          BoxModel(null, BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX), null, null), ListTypeEnum.INBOX),
    );
  }
}
