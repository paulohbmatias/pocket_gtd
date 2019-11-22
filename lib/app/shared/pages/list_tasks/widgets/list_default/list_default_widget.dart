import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/widgets/card_task_default/card_task_default_widget.dart';

class ListDefaultWidget extends StatefulWidget {
  final ListTypeEnum listType;

  ListDefaultWidget(this.listType);

  @override
  _ListDefaultWidgetState createState() => _ListDefaultWidgetState();
}

class _ListDefaultWidgetState extends State<ListDefaultWidget> {
  final bloc = ListTasksModule.to.bloc<ListTasksBloc>();

//  final scaffoldKey = GlobalKey<ScaffoldState>();

//  void showMessage(String message, TaskModel task) {
//    scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(message),
//      backgroundColor: Colors.green,
//      action: SnackBarAction(
//        onPressed: () => bloc.undo(task),
//        label: "Undo",
//      ),
//    ));
//  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
//      key: scaffoldKey,
      child: FutureBuilder<Stream<List<TaskModel>>>(
        future: bloc.listenTasks(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? StreamBuilder<List<TaskModel>>(
                  stream: bloc.boxes,
                  initialData: <TaskModel>[],
                  builder: (context, snapshot) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: snapshot.data.map((task) {
                          return Dismissible(
                            key: Key(DateTime.now()
                                .millisecondsSinceEpoch
                                .toString()),
//                            confirmDismiss: (dismissible) async {
//                              if (dismissible != DismissDirection.endToStart) {
////                                showMessage(
////                                    S.of(context).task_marked_completed, task);
//                                return true;
//                              }
//                              bool result;
//                              await showDialog<bool>(
//                                  context: context,
//                                  builder: (context) => AlertDialog(
//                                        title: Text(
//                                            S.of(context).confirm_delete_box),
//                                        content: Text(S
//                                            .of(context)
//                                            .this_box_contains(
//                                                snapshot.data.toString())),
//                                        actions: <Widget>[
//                                          FlatButton(
//                                              onPressed: () {
//                                                result = false;
//                                                Navigator.of(context).pop();
//                                              },
//                                              child: Text("No")),
//                                          FlatButton(
//                                              onPressed: () {
//                                                result = true;
//                                                Navigator.of(context).pop();
//                                              },
//                                              child: Text("Yes")),
//                                        ],
//                                      ));
//                              return result;
//                            },
                            onDismissed: (dismissible) async {
                              if (dismissible == DismissDirection.endToStart) {
                                await bloc.removeTask(task);
                              } else {
                                await bloc.done(task);
                              }
                            },
                            secondaryBackground: Container(
//                              color: CupertinoColors.ac,
                              padding: const EdgeInsets.all(16),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  CupertinoIcons.delete,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ),
                            direction:
                                widget.listType != ListTypeEnum.NEXT_ACTIONS
                                    ? DismissDirection.endToStart
                                    : DismissDirection.horizontal,
                            background: Container(
                              color: CupertinoColors.activeGreen,
                            ),
                            child: CardTaskDefaultWidget(widget.listType, task),
                          );
                        }).toList(),
                      ),
                    );
                  })
              : Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
