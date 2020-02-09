import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/modules/routines/routines_bloc.dart';
import 'package:pocket_gtd/app/modules/routines/routines_module.dart';
import 'package:pocket_gtd/app/modules/routines/widgets/card_routine/card_routine_widget.dart';
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
                      return CardRoutineWidget(item);
                    }).toList(),
                  )
                : Container();
          },
        );
      },
    );
  }
}
