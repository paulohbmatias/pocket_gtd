  import 'package:pocket_gtd/app/shared/pages/register_task/register_task_bloc.dart';
  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/pages/register_task/register_task_page.dart';
  
  class RegisterTaskModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((i) => RegisterTaskBloc()),];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterTaskPage();

  static Inject get to => Inject<RegisterTaskModule>.of();

}
  