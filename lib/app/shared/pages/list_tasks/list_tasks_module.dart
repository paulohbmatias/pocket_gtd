import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_page.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/default_task_details/default_task_details_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_bloc.dart';

class ListTasksModule extends ModuleWidget {
  final BoxModel box;
  final ListTypeEnum listType;
  final int pageToReturn;

  ListTasksModule(this.box, this.listType, {this.pageToReturn});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => BoxOptionsBloc(this.box)),
        Bloc((i) => DefaultTaskDetailsBloc()),
        Bloc((i) => ListDefaultBloc()),
        Bloc((i) => ListTasksBloc(box, listType)),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ListTasksPage(listType, box);

  static Inject get to => Inject<ListTasksModule>.of();
}
