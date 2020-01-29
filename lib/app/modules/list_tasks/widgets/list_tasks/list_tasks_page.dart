import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_default/card_task_default_widget.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class ListTasksWidget extends StatelessWidget {
  final List<TaskModel> listTasks;
  final ListTypeEnum listType;
  final BoxModel box;
  final Widget emptyList;
  final bloc = ListTasksModule.to.bloc<ListTasksBloc>();
  final GlobalKey<ScaffoldState> scaffoldKey;

  ListTasksWidget({
    Key key,
    @required this.listTasks,
    @required this.listType,
    @required this.box,
    @required this.emptyList,
    @required this.scaffoldKey,
  }) : super(key: key);

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
    listTasks.sort((task1, task2) {
      return task2.priority.index.compareTo(task1.priority.index);
    });
    return Scaffold(
        body: listTasks != null && listTasks.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(2),
                // margin: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.separated(
                  itemCount: listTasks.length,
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  itemBuilder: (context, index) {
                    TaskModel task = listTasks[index];
                    switch (listType) {
                      case ListTypeEnum.NEXT_ACTIONS:
                        return CardTaskDefaultWidget(
                          listType,
                          box,
                          task,
                          hasCheckBox: true,
                          scaffoldKey: this.scaffoldKey,
                        );
                      case ListTypeEnum.SCHEDULEDS:
                        return CardTaskDefaultWidget(
                          listType,
                          box,
                          task,
                          hasCheckBox: true,
                          scaffoldKey: this.scaffoldKey,
                        );
                      case ListTypeEnum.WAITING:
                        return CardTaskDefaultWidget(
                          listType,
                          box,
                          task,
                          hasCheckBox: true,
                          scaffoldKey: this.scaffoldKey,
                        );
                      default:
                        return CardTaskDefaultWidget(listType, box, task);
                    }
                  },
                ),
              )
            : emptyList);
  }
}
