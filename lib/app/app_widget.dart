import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/splash/splash_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Pocket GTD',
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback:
          S.delegate.resolution(fallback: new Locale("en", "")),
      home: SplashModule()
    );
  }
}
