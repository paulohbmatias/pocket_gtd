import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class BoxOptionsWidget extends StatelessWidget {
  final bloc = ListTasksModule.to.bloc<BoxOptionsBloc>();
  final TaskModel task;

  BoxOptionsWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<BoxModel>>(
        future: bloc.getBoxes(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView(
                  shrinkWrap: true,
                  children: snapshot.data
                      .map<Widget>((item) => ListTile(
                            onTap: () => bloc.moveTo(context, task, item),
                            leading: Icon(
                              IconData(
                                item.icon.codePoint,
                                fontPackage: item.icon.fontPackage,
                                fontFamily: item.icon.fontFamily
                              ),
                              size: 32,
                            ),
                            title: Text(item.title),
                          ))
                      .toList(),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
