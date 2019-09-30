import 'package:flutter/material.dart';
import 'package:pocket_gtd/modules/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/modules/dashboard/dashboard_page.dart';
import 'package:provider/provider.dart';

class DashboardProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DashboardBloc>(
      builder: (_) => DashboardBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: DashboardPage(),
    );
  }
}