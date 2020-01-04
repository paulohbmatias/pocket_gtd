import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class BoxOptionsWidget extends StatelessWidget {
  final bloc = ListTasksModule.to.bloc<BoxOptionsBloc>();
  final BoxModel boxLocal;
  final TaskModel task;

  BoxOptionsWidget(this.task, this.boxLocal);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<BoxModel>>(
        future: bloc.getBoxes(boxLocal),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView(
                  shrinkWrap: true,
                  children: snapshot.data
                      .where((item) =>
                          item.idLocal !=
                              BoxModel.getIdFromEnum(
                                  InitialBoxesEnum.SCHEDULED) &&
                          item.idLocal !=
                              BoxModel.getIdFromEnum(InitialBoxesEnum.DONE))
                      .map<Widget>((item) => ListTile(
                            onTap: () =>
                                bloc.moveTo(context, task, boxLocal, item),
                            leading: Icon(
                              IconData(item.icon.codePoint,
                                  fontPackage: item.icon.fontPackage,
                                  fontFamily: item.icon.fontFamily),
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
