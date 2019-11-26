import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';

class WhoIsGoingToDoWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Who will accomplish this task?"),
      content: Text("Who will be responsible for performing the task?"),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.DELEGATE), child: Text("Someone else")),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.IS_IT_TEMPORAL), child: Text("Me"))
      ],
    );
  }
}
