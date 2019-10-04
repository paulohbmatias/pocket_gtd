import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/pages/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: DashboardModule(),
    );
  }
}
  