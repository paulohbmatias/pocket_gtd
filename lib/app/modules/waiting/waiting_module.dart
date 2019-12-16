import 'package:pocket_gtd/app/modules/waiting/waiting_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/waiting/waiting_page.dart';

class WaitingModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => WaitingBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => WaitingPage();

  static Inject get to => Inject<WaitingModule>.of();
}
