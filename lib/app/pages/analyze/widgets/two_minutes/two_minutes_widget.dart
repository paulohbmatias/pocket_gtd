import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/two_minutes/two_minutes_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class TwoMinutesWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).app_pages_analyze_two_minutes_title),
      content: Text(S.of(context).app_pages_analyze_two_minutes_content),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.WHO_IS_GOING_TO_DO), child: Text(S.of(context).no)),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.DO), child: Text(S.of(context).yes)),
      ],
    );
  }
}
