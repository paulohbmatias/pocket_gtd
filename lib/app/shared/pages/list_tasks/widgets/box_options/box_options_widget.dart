import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/box_options/box_options_bloc.dart';

class BoxOptionsWidget extends StatelessWidget {

  final bloc = ListTasksModule.to.bloc<BoxOptionsBloc>();
  final TaskModel task;

  BoxOptionsWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BoxModel>>(
      future: bloc.getBoxes(),
      builder: (context, snapshot){
        return snapshot.hasData ? ListView(
          children: snapshot.data.map<Widget>((item) => ListTile(
            onTap: () => bloc.moveTo(task, item),
            title: Text(item.title),
          )).toList(),
        ) : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
