import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
class CardTaskDefaultWidget extends StatelessWidget {
  final TaskModel task;

  CardTaskDefaultWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(task.title),
      initiallyExpanded: true,
      leading: Icon(MdiIcons.noteText, size: 32),
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(task.content),
        ),
        ListTile(
          trailing: FlatButton(onPressed: (){}, child: Text("Save")),
        )
        
      ],
    );
  }
}
