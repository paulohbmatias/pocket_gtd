  import 'package:pocket_gtd/app/shared/pages/register/widgets/register_reference/register_reference_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_task/register_task_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_box/register_box_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_page.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class RegisterModule extends ModuleWidget {

  final AddOptionsEnum type;

  RegisterModule(this.type);

  @override
  List<Bloc> get blocs => [Bloc((i) => RegisterReferenceBloc()),
        Bloc((i) => RegisterTaskBloc()),
        Bloc((i) => RegisterBoxBloc()),
        Bloc((i) => RegisterBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterPage(type);

  static Inject get to => Inject<RegisterModule>.of();
}