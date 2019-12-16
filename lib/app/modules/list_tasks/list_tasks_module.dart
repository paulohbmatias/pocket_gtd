import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_next_actions/card_task_next_actions_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_scheduled/card_task_scheduled_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/delegate/delegate_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_page.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/list_default/list_default_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class ListTasksModule extends ModuleWidget {
  final BoxModel box;
  final ListTypeEnum listType;
  final Widget emptyList;
  final Stream<List<TaskModel>> streamListTasks;

  ListTasksModule(this.box, this.listType, this.emptyList,
      {this.streamListTasks});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => CardTaskNextActionsBloc()),
        Bloc((i) => CardTaskScheduledBloc(this.box)),
        Bloc((i) => DelegateBloc()),
        Bloc((i) => BoxOptionsBloc(this.box)),
        Bloc((i) => ListDefaultBloc()),
        Bloc((i) => CardTaskDefaultBloc(this.box)),
        Bloc((i) => ListTasksBloc(box, listType,
            streamListTasks: this.streamListTasks)),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ListTasksPage(listType, emptyList, box);

  static Inject get to => Inject<ListTasksModule>.of();
}
