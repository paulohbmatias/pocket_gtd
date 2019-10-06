import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/register/register_widget.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:unicorndial/unicorndial.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(),
      floatingActionButton: UnicornDialer(
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: <UnicornButton>[
            UnicornButton(
                hasLabel: true,
                labelText: S.of(context).task,
                labelBackgroundColor: Colors.transparent,
                labelHasShadow: false,
                currentButton: FloatingActionButton(
                  heroTag: "task",
                  mini: true,
                  child: Icon(MdiIcons.noteText),
                  onPressed: () => _showAlert(context, TaskType.TASK),
                )),
            UnicornButton(
                hasLabel: true,
                labelText: S.of(context).project,
                labelBackgroundColor: Colors.transparent,
                labelHasShadow: false,
                currentButton: FloatingActionButton(
                  heroTag: "project",
                  mini: true,
                  child: Icon(Icons.computer),
                  onPressed: () {},
                )),
            UnicornButton(
                hasLabel: true,
                labelText: S.of(context).event,
                labelBackgroundColor: Colors.transparent,
                labelHasShadow: false,
                currentButton: FloatingActionButton(
                  heroTag: "event",
                  mini: true,
                  child: Icon(Icons.event),
                  onPressed: () {},
                )),
            UnicornButton(
                hasLabel: true,
                labelText: S.of(context).reference,
                labelBackgroundColor: Colors.transparent,
                labelHasShadow: false,
                currentButton: FloatingActionButton(
                  heroTag: "reference",
                  mini: true,
                  child: Icon(MdiIcons.fileOutline),
                  onPressed: () {},
                )),
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
