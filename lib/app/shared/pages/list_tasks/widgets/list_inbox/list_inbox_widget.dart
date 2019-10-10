import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_inbox/card_task_inbox_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_inbox/list_inbox_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';
class ListInboxWidget extends StatefulWidget {
  @override
  _ListInboxWidgetState createState() => _ListInboxWidgetState();
}

class _ListInboxWidgetState extends State<ListInboxWidget> {
  final bloc = ListTasksModule.to.bloc<ListInboxBloc>();
  Future<Stream<List<TaskModel>>> listTasks;

  @override
  void initState() {
    listTasks = bloc.listenTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<List<TaskModel>>>(
      future: listTasks,
      builder: (context, snapshot){
        return snapshot.hasData ? StreamBuilder<List<TaskModel>>(
            stream: bloc.boxes,
            initialData: <TaskModel>[],
            builder: (context, snapshot) {
              return ListView(
                children: snapshot.data.map((task) {
                  return Dismissible(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    confirmDismiss: (dismissible) async {
                      bool result;
                      await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(S.of(context).confirm_delete_box
                            ),
                            content: Text(S.of(context).this_box_contains(snapshot.data.toString())),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    result = false;
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No")),
                              FlatButton(
                                  onPressed: () {
                                    result = true;
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Yes")),
                            ],
                          ));
                      return result;
                    },
                    onDismissed: (dismissible) async {
                      await bloc.removeTask(task);
                    },
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    dragStartBehavior: DragStartBehavior.start,
                    direction: DismissDirection.endToStart,
                    child: CardTaskInboxWidget(task),
                  );
                }).toList(),
              );
            }) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
  