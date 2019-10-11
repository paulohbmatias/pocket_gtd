import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_widget.dart';

class ListTasksPage extends StatelessWidget {
  final ListTypeEnum listType;

  ListTasksPage(this.listType);

  @override
  Widget build(BuildContext context) {
    if (listType == ListTypeEnum.DEFAULT)
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          ),
          body: ListDefaultWidget(listType));
    else
      return Material(
        child: ListDefaultWidget(listType),
      );
  }
}
