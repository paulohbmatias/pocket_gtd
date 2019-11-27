import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class ActionableWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).app_pages_analyze_actionable_title),
      content: Text(S.of(context).app_pages_analyze_actionable_content),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.CHOICE_NOT_ACTIONABLE), child: Text(S.of(context).no)),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.TWO_MINUTES), child: Text(S.of(context).yes)),
      ],
    );
  }
}