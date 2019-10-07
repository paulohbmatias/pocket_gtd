import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/widgets/register_task/register_task_bloc.dart';
import 'package:pocket_gtd/app/shared/widgets/register_task/register_task_widget.dart';

class RegisterTaskModule extends ModuleWidget {

  final BoxModel box;

  RegisterTaskModule(this.box);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => RegisterTaskBloc())
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterTaskWidget();

  static Inject get to => Inject<RegisterTaskModule>.of();
}
