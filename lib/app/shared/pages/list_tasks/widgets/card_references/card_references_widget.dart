import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
class CardReferencesWidget extends StatelessWidget {
  final TaskModel task;

  CardReferencesWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(task.title),
      leading: Icon(MdiIcons.noteText, size: 32),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(task.content),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(onPressed: (){}, child: Text("Delete")),
              FlatButton(onPressed: (){}, child: Text("Edit")),
              FlatButton(onPressed: (){}, child: Text("Move")),
            ],
          ),
        )

      ],
    );
  }
}
  