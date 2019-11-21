import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/splash/splash_bloc.dart';
import 'package:pocket_gtd/app/pages/splash/splash_module.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final bloc = SplashModule.to.bloc<SplashBloc>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: bloc.load(context),
        builder: (context, snapshot) {
          return Center(child: CircularProgressIndicator());
        });
  }
}
