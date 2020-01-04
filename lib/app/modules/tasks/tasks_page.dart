import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/modules/next_actions/next_actions_module.dart';
import 'package:pocket_gtd/app/modules/scheduled/scheduled_module.dart';
import 'package:pocket_gtd/app/modules/waiting/waiting_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class TasksPage extends StatefulWidget {
  final String title;
  const TasksPage({Key key, this.title = "Tasks"}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

final pages =[
  InboxModule(),
  NextActionsModule(),
  ScheduledModule(),
  Container(),
  WaitingModule(),
  Container(),
];

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      initialIndex: 1,
      child: Material(
        child: Column(
          children: <Widget>[
            Container(
              // color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
                isScrollable: true,
                dragStartBehavior: DragStartBehavior.down,
                tabs: <Widget>[
                  Tab(text: I18n.of(context).inbox),
                  Tab(
                    text: I18n.of(context).next_actions,
                  ),
                  Tab(text: I18n.of(context).scheduled),
                  Tab(text: I18n.of(context).references),
                  Tab(text: I18n.of(context).waiting),
                  Tab(text: I18n.of(context).one_day_maybe),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: pages,
              ),
            )
          ],
        ),
      ),
    );
  }
}
