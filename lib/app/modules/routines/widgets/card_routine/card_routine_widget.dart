import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/routines/routines_bloc.dart';
import 'package:pocket_gtd/app/modules/routines/routines_module.dart';
import 'package:pocket_gtd/app/shared/mixins/card_task_mixin.dart';
import 'package:pocket_gtd/app/shared/models/item_menu_task_model.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardRoutineWidget extends StatelessWidget with CardMixin {
  final bloc = RoutinesModule.to.bloc<RoutinesBloc>();
  final RoutineModel routine;

  CardRoutineWidget(this.routine);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        onTapDown: (pos) async {
          int result = await showOptions(
            context,
            RelativeRect.fromLTRB(
              pos.globalPosition.dx,
              pos.globalPosition.dy,
              pos.globalPosition.dx,
              pos.globalPosition.dy,
            ),
            <ItemMenuTaskModel>[
              ItemMenuTaskModel(0, OMIcons.edit, I18n.of(context).edit),
              ItemMenuTaskModel(1, OMIcons.delete, I18n.of(context).remove),
            ],
          );
          if (result != null) {
            switch (result) {
              case 0:
                bloc.edit(context, routine);
                break;
              case 1:
                bloc.remove(routine);
                break;
            }
          }
        },
        child: ListTile(
          title: Text(routine.title),
          isThreeLine: true,
          subtitle: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                routine.details != null ? Text(routine.details) : Container(),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          MdiIcons.calendarCheck,
                          size: 12,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: Text(
                            routine.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          trailing: Switch(
              value: routine.isActive,
              onChanged: (value) => bloc.activeRoutine(routine, value)),
        ));
  }
}
