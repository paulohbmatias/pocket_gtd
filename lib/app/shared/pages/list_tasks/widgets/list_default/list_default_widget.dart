import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_default/card_task_default_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';

class ListDefaultWidget extends StatefulWidget {
  final ListTypeEnum listType;

  ListDefaultWidget(this.listType);

  @override
  _ListDefaultWidgetState createState() => _ListDefaultWidgetState();
}

class _ListDefaultWidgetState extends State<ListDefaultWidget> {
  final bloc = ListTasksModule.to.bloc<ListTasksBloc>();
  Future<Stream<List<TaskModel>>> listTasks;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    listTasks = bloc.listenTasks();
    super.initState();
  }

  void showMessage(String message, TaskModel task) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        onPressed: () => bloc.undo(task),
        label: "Undo",
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: FutureBuilder<Stream<List<TaskModel>>>(
        future: listTasks,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? StreamBuilder<List<TaskModel>>(
                  stream: bloc.boxes,
                  initialData: <TaskModel>[],
                  builder: (context, snapshot) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(2),
                      child: ListView.separated(
                        itemCount: snapshot.data.length,
                        separatorBuilder: (context, index) {
                          return Container();
                        },
                        itemBuilder: (context, index) {
                          TaskModel task = snapshot.data[index];
                          return CardTaskDefaultWidget(widget.listType, task);
                        },
                      ),
                    );
                  })
              : Container();
        },
      ),
    );
  }
}
