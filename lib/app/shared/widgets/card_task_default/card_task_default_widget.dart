import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/default_task_details/default_task_details_widget.dart';
import 'package:pocket_gtd/app/shared/widgets/card_task_default/card_task_default_bloc.dart';

class CardTaskDefaultWidget extends StatelessWidget {
  final TaskModel task;
  final ListTypeEnum listType;
  final bloc = AppModule.to.bloc<CardTaskDefaultBloc>();
  CardTaskDefaultWidget(this.listType, this.task);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Theme(
            data: ThemeData.dark(),
            child: Material(
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                title: Text(task.title),
                subtitle: Text(task.content),
//            onTap: () => bloc.edit(context, ListTypeEnum.DEFAULT, this.task),
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
//                    cancelButton: CupertinoButton(
//                      onPressed: () => Navigator.of(context).pop(),
//                      child: Text("CANCEL"),
//                    ),
                            actions: <Widget>[
                              CupertinoButton(
                                child: Text("EDIT"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  bloc.edit(context, ListTypeEnum.DEFAULT, this.task);
                                },
                              ),
                              CupertinoButton(
                                child: Text("MOVE"),
                                onPressed: () {},
                              ),
                              CupertinoButton(
                                child: Text("ANALYZE"),
                                onPressed: () {},
                              ),
                              CupertinoButton(
                                child: Text("REMOVE"),
                                onPressed: () {},
                              ),
                            ],
                          ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDetails(BuildContext context, TaskModel task) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: DefaultTaskDetailsWidget(task)),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) => DefaultTaskDetailsWidget(task));
  }
}
