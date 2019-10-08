import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class ListTasksModule extends ModuleWidget {
  final BoxModel box;

  ListTasksModule(this.box);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => CardTaskDefaultBloc()),
        Bloc((i) => ListDefaultBloc(this.box)),
        Bloc((i) => ListTasksBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ListTasksPage(box);

  static Inject get to => Inject<ListTasksModule>.of();
}
