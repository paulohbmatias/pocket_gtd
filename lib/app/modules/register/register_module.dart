import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register/register_bloc.dart';
import 'package:pocket_gtd/app/modules/register/register_page.dart';
import 'package:pocket_gtd/app/modules/register/widgets/register_box/register_box_bloc.dart';
import 'package:pocket_gtd/app/modules/register/widgets/register_reference/register_reference_bloc.dart';
import 'package:pocket_gtd/app/modules/register/widgets/register_task/register_task_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class RegisterModule extends ModuleWidget {
  final ListTypeEnum type;
  final TaskModel task;
  final bool isUpdate;

  RegisterModule(this.type, {this.task, this.isUpdate = false});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => RegisterReferenceBloc(task: task, isUpdate: isUpdate)),
        Bloc((i) => RegisterTaskBloc(task: task, isUpdate: this.isUpdate)),
        Bloc((i) => RegisterBoxBloc()),
        Bloc((i) => RegisterBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterPage(type);

  static Inject get to => Inject<RegisterModule>.of();
}
