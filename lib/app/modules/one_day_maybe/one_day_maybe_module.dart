import 'package:pocket_gtd/app/modules/one_day_maybe/one_day_maybe_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/one_day_maybe/one_day_maybe_page.dart';

class OneDayMaybeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => OneDayMaybeBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => OneDayMaybePage();

  static Inject get to => Inject<OneDayMaybeModule>.of();
}
