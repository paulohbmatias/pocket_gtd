import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/modules/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class TwoMinutesWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(I18n.of(context).app_pages_analyze_two_minutes_title),
      content: Text(I18n.of(context).app_pages_analyze_two_minutes_content),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.WHO_IS_GOING_TO_DO), child: Text(I18n.of(context).no)),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.DO), child: Text(I18n.of(context).yes)),
      ],
    );
  }
}
