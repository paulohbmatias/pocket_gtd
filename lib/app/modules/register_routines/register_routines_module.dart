import 'package:pocket_gtd/app/modules/register_routines/register_routines_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_page.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';

class RegisterRoutinesModule extends ModuleWidget {
  final RoutineModel routine;
  final bool isUpdate;

  RegisterRoutinesModule({this.routine, this.isUpdate = false});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => RegisterRoutinesBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterRoutinesPage();

  static Inject get to => Inject<RegisterRoutinesModule>.of();
}
