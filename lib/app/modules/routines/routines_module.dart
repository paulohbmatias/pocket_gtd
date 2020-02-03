import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/routines/routines_bloc.dart';
import 'package:pocket_gtd/app/modules/routines/routines_page.dart';
import 'package:pocket_gtd/app/modules/routines/widgets/list_routines/list_routines_bloc.dart';

class RoutinesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ListRoutinesBloc()),
        Bloc((i) => RoutinesBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RoutinesPage();

  static Inject get to => Inject<RoutinesModule>.of();
}
