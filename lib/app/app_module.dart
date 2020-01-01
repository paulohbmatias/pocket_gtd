import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_with_mark_done/card_task_with_mark_done_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_bloc.dart';
import 'package:pocket_gtd/app/app_widget.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/box_repository_impl.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/task_repository_impl.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => CardTaskWithMarkDoneBloc()),
        Bloc((i) => CardTaskWithMarkDoneBloc()),
        Bloc((i) => BoxOptionsBloc()),
        Bloc((i) => CardTaskDefaultBloc()),
        Bloc((i) => ListTasksBloc()),
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => BoxRepositoryImpl()),
        Dependency((i) => TaskRepositoryImpl()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
