import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';

class DefaultTaskDetailsWidget extends StatelessWidget {
  final TaskModel task;
  final bloc = ListTasksModule.to.bloc<ListTasksBloc>();

  DefaultTaskDetailsWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              bloc.removeTask(task);
              Navigator.of(context).pop();
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
        FlatButton(
            onPressed: () => bloc.edit(context, task),
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
        Builder(builder: (context){
          if (bloc.box.idLocal == BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX)){
            return FlatButton(
                onPressed: () {},
                child: Text(
                  "Analyze",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ));
          }else if(bloc.box.idLocal == BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS)){
            return FlatButton(
                onPressed: () async{
                  await bloc.done(task);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Done",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ));
          }
          return Container();
        })
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
                        "${(task.deadline.day).toString().padLeft(2, "0")}/${(task.deadline.month).toString().padLeft(2, "0")}"
                            "/${(task.deadline.year).toString().padLeft(2, "0")}",
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
