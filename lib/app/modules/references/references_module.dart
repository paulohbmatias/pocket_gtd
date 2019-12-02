import 'package:pocket_gtd/app/modules/references/references_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/references/references_page.dart';

class ReferencesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ReferencesBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ReferencesPage();

  static Inject get to => Inject<ReferencesModule>.of();
}
