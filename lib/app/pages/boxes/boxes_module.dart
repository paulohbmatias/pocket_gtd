  import 'package:pocket_gtd/app/pages/boxes/widgets/register/register_bloc.dart';
  import 'package:pocket_gtd/app/pages/boxes/boxes_bloc.dart';
  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_page.dart';
  
  class BoxesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((i) => RegisterBloc()),Bloc((i) => BoxesBloc()),];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => BoxesPage();

  static Inject get to => Inject<BoxesModule>.of();

}
  