import 'package:pocket_gtd/app/modules/dashboard/widgets/app_bar/app_bar_bloc.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_page.dart';

class DashboardModule extends ModuleWidget {
  final int page;

  DashboardModule({this.page});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBarBloc()),
        Bloc((i) => DashboardBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => DashboardPage(page: page);

  static Inject get to => Inject<DashboardModule>.of();
}
