import 'package:pocket_gtd/app/modules/next_actions/next_actions_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/next_actions/next_actions_page.dart';

class NextActionsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => NextActionsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => NextActionsPage();

  static Inject get to => Inject<NextActionsModule>.of();
}
