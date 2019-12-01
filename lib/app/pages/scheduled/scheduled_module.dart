import 'package:pocket_gtd/app/pages/scheduled/scheduled_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/scheduled/scheduled_page.dart';

class ScheduledModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ScheduledBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ScheduledPage();

  static Inject get to => Inject<ScheduledModule>.of();
}
