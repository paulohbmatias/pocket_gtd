import 'package:pocket_gtd/app/modules/routines/routines_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/routines/routines_page.dart';

class RoutinesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => RoutinesBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RoutinesPage();

  static Inject get to => Inject<RoutinesModule>.of();
}
