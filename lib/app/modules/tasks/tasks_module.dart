import 'package:pocket_gtd/app/modules/tasks/tasks_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/tasks/tasks_page.dart';

class TasksModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => TasksBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => TasksPage();

  static Inject get to => Inject<TasksModule>.of();
}
