import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_page.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/actionable/actionable_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/choice_not_actionable/choice_not_actionable_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/delegate/delegate_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/do/do_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/is_it_temporal/is_it_temporal_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/two_minutes/two_minutes_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/who_is_going_to_do/who_is_going_to_do_bloc.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class AnalyzeModule extends ModuleWidget {
  final TaskModel task;

  AnalyzeModule(this.task);
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AnalyzeBloc()),
        Bloc((i) => DelegateBloc(this.task)),
        Bloc((i) => DoBloc(this.task)),
        Bloc((i) => ChoiceNotActionableBloc(this.task)),
        Bloc((i) => IsItTemporalBloc()),
        Bloc((i) => WhoIsGoingToDoBloc()),
        Bloc((i) => TwoMinutesBloc()),
        Bloc((i) => ActionableBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AnalyzePage(task: this.task);

  static Inject get to => Inject<AnalyzeModule>.of();
}
