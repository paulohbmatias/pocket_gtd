import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_page.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class AnalyzeModule extends ModuleWidget {
  final TaskModel task;

  AnalyzeModule(this.task);
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AnalyzeBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AnalyzePage(task: this.task);

  static Inject get to => Inject<AnalyzeModule>.of();
}
