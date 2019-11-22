import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/shared/utils/date_utils.dart';

class CardTaskDefaultWidget extends StatelessWidget {
  final TaskModel task;
  final ListTypeEnum listType;
  final bloc = ListTasksModule.to.bloc<CardTaskDefaultBloc>();

  CardTaskDefaultWidget(this.listType, this.task);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              title: Text(task.title),
              subtitle: Text(task.content),
              trailing: task.deadline != null
                  ? Text(
                      "${task.deadline.day} ${DateUtils.monthFromDate(task.deadline)}",
                      style: TextStyle(
                        color: Color(0xffff7e67),
                        fontWeight: FontWeight.bold
                      ),
                    )
                  : Text(""),
              onTap: (){
                showDialog(context: context, builder: (context){
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => bloc.edit(context, ListTypeEnum.DEFAULT, task),
                          textColor: Theme.of(context).accentColor,
                          child: Text("EDIT"),
                        ),
                        FlatButton(
                          onPressed: () => bloc.showOptionsBoxes(context, task),
                          textColor: Theme.of(context).accentColor,
                          child: Text("MOVE"),
                        ),
                        FlatButton(
                          onPressed: (){},
                          textColor: Theme.of(context).accentColor,
                          child: Text("PROCESS"),
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
