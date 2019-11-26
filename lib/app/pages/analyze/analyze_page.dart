import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/choice_not_actionable/choice_not_actionable_widget.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/do/do_widget.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/delegate/delegate_widget.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/actionable/actionable_widget.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/is_it_temporal/is_it_temporal_widget.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/two_minutes/two_minutes_widget.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/who_is_going_to_do/who_is_going_to_do_widget.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class AnalyzePage extends StatefulWidget {
  final TaskModel task;
  const AnalyzePage({Key key, @required this.task}) : super(key: key);

  @override
  _AnalyzePageState createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StepsEnum>(
      stream: bloc.step,
      initialData: StepsEnum.ACTIONABLE,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case StepsEnum.ACTIONABLE:
            return ActionableWidget();
          case StepsEnum.TWO_MINUTES:
            return TwoMinutesWidget();
          case StepsEnum.WHO_IS_GOING_TO_DO:
            return WhoIsGoingToDoWidget();
            break;
          case StepsEnum.IS_IT_TEMPORAL:
            return IsItTemporalWidget();
          case StepsEnum.CHOICE_NOT_ACTIONABLE:
            return ChoiceNotActionableWidget();
          case StepsEnum.DO:
            return DoWidget();
          case StepsEnum.DELEGATE:
            return DelegateWidget();
          default: return Container();
        }
      },
    );
  }
}
