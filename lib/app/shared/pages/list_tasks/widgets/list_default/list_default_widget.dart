import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_default/card_task_default_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';
class ListDefaultWidget extends StatefulWidget {
  @override
  _ListDefaultWidgetState createState() => _ListDefaultWidgetState();
}

class _ListDefaultWidgetState extends State<ListDefaultWidget> {
  final bloc = ListTasksModule.to.bloc<ListDefaultBloc>();
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
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: ListView(
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
                      child: CardTaskDefaultWidget(task),
                    );
                  }).toList(),
                ),
              );
            }) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
  