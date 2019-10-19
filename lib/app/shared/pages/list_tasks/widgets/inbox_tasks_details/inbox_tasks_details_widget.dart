import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class InboxTasksDetailsWidget extends StatelessWidget {
  final TaskModel task;

  InboxTasksDetailsWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        FlatButton(
            onPressed: () {},
            child: Text(
              "Delete",
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
        FlatButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
        FlatButton(
            onPressed: () {},
            child: Text(
              "Move",
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
        FlatButton(
            onPressed: () {},
            child: Text(
              "Analyze",
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
      ],
      title: Row(
        children: <Widget>[
          Icon(MdiIcons.noteText),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(task.title),
          )
        ],
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(task.content),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: task.deadline != null
                  ? RichText(
                      text: TextSpan(
                        text: 'Deadline:  ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "${task.deadline.day}/${task.deadline.month}"
                                      "/${task.deadline.year}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}
