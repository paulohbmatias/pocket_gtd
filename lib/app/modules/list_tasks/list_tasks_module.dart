import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_page.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class ListTasksModule extends ModuleWidget {
  final ListTypeEnum listType;
  final List<TaskModel> tasks;
  final BoxModel box;
  final Widget emptyList;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ListTasksModule(this.listType, this.box, this.tasks, this.emptyList,
      {this.scaffoldKey});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => ListTasksBloc()),
        Bloc((i) => BoxOptionsBloc()),
        Bloc((i) => CardTaskDefaultBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => ListTasksPage(
        this.listType,
        this.box,
        this.tasks,
        this.emptyList,
        scaffoldKey: this.scaffoldKey,
      );

  static Inject get to => Inject<ListTasksModule>.of();
}
