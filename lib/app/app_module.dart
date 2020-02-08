import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_bloc.dart';
import 'package:pocket_gtd/app/app_widget.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/box_repository_impl.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/routine_repository_impl.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/task_repository_impl.dart';
import 'package:pocket_gtd/app/shared/utils/notification_utils.dart';
import 'package:pocket_gtd/app/shared/utils/routine_utils.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => BoxRepositoryImpl()),
        Dependency((i) => TaskRepositoryImpl()),
        Dependency((i) => RoutineRepositoryImpl()),
        Dependency((i) => NotificationUtils()),
        Dependency((i) => RoutineUtils()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
