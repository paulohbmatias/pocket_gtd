import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/default_task_details/default_task_details_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/inbox_tasks_details/inbox_tasks_details_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_page.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_references/card_references_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_default/card_task_default_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_inbox/card_task_inbox_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/card_task_next_actions/card_task_next_actions_bloc.dart';

class ListTasksModule extends ModuleWidget {
  final BoxModel box;
  final ListTypeEnum listType;

  ListTasksModule(this.box, this.listType);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => DefaultTaskDetailsBloc()),
        Bloc((i) => InboxTasksDetailsBloc()),
        Bloc((i) => ListDefaultBloc(box)),
        Bloc((i) => CardReferencesBloc()),
        Bloc((i) => CardTaskNextActionsBloc()),
        Bloc((i) => CardTaskInboxBloc()),
        Bloc((i) => CardTaskDefaultBloc()),
        Bloc((i) => ListTasksBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ListTasksPage(listType);

  static Inject get to => Inject<ListTasksModule>.of();
}
