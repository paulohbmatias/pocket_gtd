import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_references/card_references_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_default/card_task_default_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_inbox/card_task_inbox_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_next_actions/card_task_next_actions_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class ListTasksPage extends StatefulWidget {

  final BoxModel box;
  final ListTypeEnum listType;

  ListTasksPage(this.box, this.listType);

  @override
  _ListTasksPageState createState() => _ListTasksPageState();
}

class _ListTasksPageState extends State<ListTasksPage> {
  final bloc = ListTasksModule.to.bloc<ListTasksBloc>();
  Future<Stream<List<TaskModel>>> listTasks;

  @override
  void initState() {
    listTasks = bloc.listenTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Stream<List<TaskModel>>>(
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
                        child: Builder(builder: (context){
                          switch(widget.listType){
                            case ListTypeEnum.INBOX:
                              return CardTaskInboxWidget(task);
                            case ListTypeEnum.NEXT_ACTIONS:
                              return CardTaskNextActionsWidget(task);
                            case ListTypeEnum.REFERENCES:
                              return CardReferencesWidget(task);
                            default:
                              return CardTaskDefaultWidget(task);
                          }
                        }),
                      );
                    }).toList(),
                  ),
                );
              }) : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

