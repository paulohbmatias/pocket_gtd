import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/pages/list_tasks/list_tasks_page.dart';
import 'package:pocket_gtd/app/pages/list_tasks/widgets/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/pages/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/pages/list_tasks/widgets/list_default/list_default_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';

class ListTasksModule extends ModuleWidget {
  final BoxModel box;
  final ListTypeEnum listType;
  final Widget emptyList;

  ListTasksModule(this.box, this.listType, this.emptyList);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => BoxOptionsBloc(this.box)),
        Bloc((i) => ListDefaultBloc()),
        Bloc((i) => CardTaskDefaultBloc()),
        Bloc((i) => ListTasksBloc(box, listType)),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ListTasksPage(listType, emptyList, box);

  static Inject get to => Inject<ListTasksModule>.of();
}
