import 'package:flutter/material.dart';
import 'package:pocket_gtd/modules/home/home_bloc.dart';
import 'package:pocket_gtd/modules/home/home_page.dart';
import 'package:provider/provider.dart';

class HomeProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      builder: (context) => HomeBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: HomePage(),
    );
  }
}
