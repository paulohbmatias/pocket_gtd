import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class AreProjectWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
    Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).app_pages_analyze_are_project_title),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.IS_IT_TEMPORAL), child: Text(S.of(context).no)),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.MOVE_TO_PROJECT), child: Text(S.of(context).yes)),
      ],
    );
  }
}
