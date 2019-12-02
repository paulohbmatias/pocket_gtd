import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pocket_gtd/app/modules/splash/splash_bloc.dart';
import 'package:pocket_gtd/app/modules/splash/splash_module.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final bloc = SplashModule.to.bloc<SplashBloc>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<void>(
          future: bloc.load(context),
          builder: (context, snapshot) {
            return FlareActor(
              "assets/flare/logo.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "splash",
            );
          }),
    );
  }
}
