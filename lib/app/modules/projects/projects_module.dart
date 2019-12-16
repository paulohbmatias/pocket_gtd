import 'package:pocket_gtd/app/modules/projects/projects_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/projects/projects_page.dart';

class ProjectsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ProjectsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ProjectsPage();

  static Inject get to => Inject<ProjectsModule>.of();
}
