import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';

class ActionableWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Is it actionable?"),
      content: Text("Is this task actionable? ie do you have all the resources to accomplish it?"),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.CHOICE_NOT_ACTIONABLE), child: Text("No")),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.TWO_MINUTES), child: Text("Yes")),
      ],
    );
  }
}
