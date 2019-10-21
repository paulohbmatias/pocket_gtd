import 'package:pocket_gtd/app/pages/dashboard/dashboard_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_page.dart';

class DashboardModule extends ModuleWidget {

  final int page;

  DashboardModule({this.page});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => DashboardBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => DashboardPage(page: page);

  static Inject get to => Inject<DashboardModule>.of();
}
