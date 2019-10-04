import 'package:pocket_gtd/app/pages/tasks/tasks_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/tasks/tasks_page.dart';

class TasksModule extends ModuleWidget {
  int boxID;
  TasksModule(this.boxID);

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
