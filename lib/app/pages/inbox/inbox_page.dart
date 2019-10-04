import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/register/register_widget.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FabCircularMenu(
          child: Container(),
          ringWidth: 80, // Replace this with your content
          ringDiameter: 200,
          fabColor: Colors.blueGrey,
          ringColor: Colors.blueGrey,
          fabOpenIcon: Icon(Icons.add),
          options: <Widget>[
            IconButton(
                icon: Icon(MdiIcons.noteText),
                color: Colors.white,
                alignment: Alignment.center,
                onPressed: () => _showAlert(context, TaskType.TASK)),
            IconButton(
                icon: Icon(Icons.computer),
                color: Colors.white,
                onPressed: () {
                  print('Pressed!');
                }),
            IconButton(
                icon: Icon(Icons.event),
                color: Colors.white,
                onPressed: () {
                  print('Pressed!');
                }),
            IconButton(
                icon: Icon(MdiIcons.fileOutline),
                color: Colors.white,
                onPressed: () {
                  print('Pressed!');
                })
          ]),
      body: Column(
        children: <Widget>[],
      ),
    );
  }

  void _showAlert(BuildContext context, TaskType taskType) {
    showDialog(context: context, builder: (context) => RegisterWidget());
  }
}
