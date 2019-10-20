import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/default_task_details/default_task_details_widget.dart';
class CardTaskDefaultWidget extends StatelessWidget {
  final TaskModel task;

  CardTaskDefaultWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(8),
              leading: Icon(MdiIcons.noteText, size: 32),
              title: Text(task.title),
              subtitle: Text(task.content),
              onTap: () => showDetails(context, task),
            ),
          ],
        ),
      ),
    );
  }

  void showDetails(BuildContext context, TaskModel task) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value, child: DefaultTaskDetailsWidget(task)),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) =>
            DefaultTaskDetailsWidget(task));
  }
}
