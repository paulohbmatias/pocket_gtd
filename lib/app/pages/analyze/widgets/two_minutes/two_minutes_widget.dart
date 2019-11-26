import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/two_minutes/two_minutes_bloc.dart';

class TwoMinutesWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Does it take less than two minutes?"),
      content: Text("Does this action take less than two minutes?"),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.WHO_IS_GOING_TO_DO), child: Text("No")),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.DO), child: Text("Yes")),
      ],
    );
  }
}
