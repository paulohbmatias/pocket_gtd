import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/widgets/register_task/register_task_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:unicorndial/unicorndial.dart';

class AddOptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnicornDialer(
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
        ]);
  }

  void _showAlert(BuildContext context, TaskType taskType) {
    showDialog(context: context, builder: (context) => RegisterTaskModule(null));
  }
}
