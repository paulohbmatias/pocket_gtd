import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';
import 'package:pocket_gtd/app/shared/repositories/routine_repository.dart';

class ListRoutinesWidget extends StatelessWidget {
  final bloc = AppModule.to.getDependency<RoutineRepository>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<List<RoutineModel>>>(
      future: bloc.listenAll(),
      builder: (context, snapshot) {
        return StreamBuilder<List<RoutineModel>>(
          stream: snapshot.data,
          builder: (context, snapshot) {
            return snapshot.hasData ? ListView(
              children: snapshot.data.map<Widget>((item){
                return ListTile(
                  title: Text(item.title),
                );
              }).toList(),
            ) : Container();
          },
        );
      },
    );
  }
}
