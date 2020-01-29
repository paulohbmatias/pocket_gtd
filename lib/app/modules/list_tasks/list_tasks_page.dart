import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/list_tasks/list_tasks_page.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class ListTasksPage extends StatefulWidget {
  final ListTypeEnum listType;
  final List<TaskModel> tasks;
  final BoxModel box;
  final Widget emptyList;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ListTasksPage(this.listType, this.box, this.tasks, this.emptyList,
      {this.scaffoldKey});

  @override
  _ListTasksPageState createState() => _ListTasksPageState();
}

class _ListTasksPageState extends State<ListTasksPage> {
  @override
  void initState() {
    widget.tasks.sort((task1, task2) {
      return task2.priority.index.compareTo(task1.priority.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTasksWidget(
          listTasks: widget.tasks,
          box: widget.box,
          listType: widget.listType,
          emptyList: widget.emptyList,
          scaffoldKey: widget.scaffoldKey),
    );
  }
}
