import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/list_default/list_default_widget.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';

class ListTasksPage extends StatelessWidget {
  final ListTypeEnum listType;
  final BoxModel box;
  final Widget emptyList;

  ListTasksPage(this.listType, this.emptyList, this.box);

  @override
  Widget build(BuildContext context) {
    if (listType == ListTypeEnum.DEFAULT)
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            title: Text(box.title, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal),),
          ),
          body: ListDefaultWidget(listType, emptyList));
    else
      return Material(
        child: ListDefaultWidget(listType, emptyList),
      );
  }
}
