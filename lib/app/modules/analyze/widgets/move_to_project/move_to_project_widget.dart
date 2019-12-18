import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class MoveToProjectWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(I18n.of(context).app_pages_analyze_move_to_project_content),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text(I18n.of(context).cancel)),
        FlatButton(onPressed: () {
          bloc.moveTo(InitialBoxesEnum.PROJECTS);
          Navigator.pop(context);
        }, child: Text(I18n.of(context).move_to_projects)),
      ],
    );
  }
}
