import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_inbox/list_inbox_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_next_actions/list_next_actions_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_references/list_references_widget.dart';

class ListTasksPage extends StatelessWidget {

  final BoxModel box;
  final ListTypeEnum listType;

  ListTasksPage(this.box, this.listType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        ),
        body: Builder(builder: (context) {
          switch(listType){
            case ListTypeEnum.INBOX:
              return ListInboxWidget();
            case ListTypeEnum.NEXT_ACTIONS:
              return ListNextActionsWidget();
            case ListTypeEnum.REFERENCES:
              return ListReferencesWidget();
            default:
              return ListDefaultWidget();
          }
        }));
  }
}
