import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/modules/routines/routines_bloc.dart';
import 'package:pocket_gtd/app/modules/routines/routines_module.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';

class ListRoutinesWidget extends StatelessWidget {
  final bloc = RoutinesModule.to.bloc<RoutinesBloc>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<List<RoutineModel>>>(
      future: bloc.listenRoutines(),
      builder: (context, snapshot) {
        return StreamBuilder<List<RoutineModel>>(
          stream: snapshot.data,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView(
                    children: snapshot.data.map<Widget>((item) {
                      return ListTile(
                        title: Text(item.title),
                        isThreeLine: true,
                        subtitle: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              item.details != null
                                  ? Text(item.details)
                                  : Container(),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: <Widget>[
                                    Icon(MdiIcons.calendarCheck, size: 12,),
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      child: Text(item.toString(), style: TextStyle(
                                        fontSize: 12
                                      ),),
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                        trailing: Switch(
                            value: item.isActive,
                            onChanged: (value) =>
                                bloc.activeRoutine(item, value)),
                      );
                    }).toList(),
                  )
                : Container();
          },
        );
      },
    );
  }
}
