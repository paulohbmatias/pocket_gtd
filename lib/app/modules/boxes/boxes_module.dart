import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/boxes/boxes_bloc.dart';
import 'package:pocket_gtd/app/modules/boxes/boxes_page.dart';
import 'package:pocket_gtd/app/modules/boxes/widgets/list_boxes/list_boxes_bloc.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/box_repository_impl.dart';

class BoxesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ListBoxesBloc()),
        Bloc((i) => BoxesBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => BoxRepositoryImpl()),
  ];

  @override
  Widget get view => BoxesPage();

  static Inject get to => Inject<BoxesModule>.of();
}
