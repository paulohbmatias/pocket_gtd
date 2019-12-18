import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/modules/analyze/widgets/choice_not_actionable/choice_not_actionable_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class ChoiceNotActionableWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<ChoiceNotActionableBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(MdiIcons.cubeOutline),
            title: Text(I18n.of(context).one_day_maybe),
            onTap: () {
              bloc.moveTo(BoxModel.fromEnum(InitialBoxesEnum.ONE_DAY_MAYBE));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.cubeOutline),
            title: Text(I18n.of(context).references),
            onTap: () {
              bloc.moveTo(BoxModel.fromEnum(InitialBoxesEnum.REFERENCES));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.trashCan),
            title: Text(I18n.of(context).trash),
            onTap: () {
              bloc.remove();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
