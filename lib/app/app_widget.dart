import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/splash/splash_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket GTD',
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback:
          S.delegate.resolution(fallback: new Locale("en", "")),
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xff1c4b82,
          <int, Color>{
            50: Color(0xFFe4e9f0),
            100: Color(0xFFbbc9da),
            200: Color(0xFF8ea5c1),
            300: Color(0xFF6081a8),
            400: Color(0xFF3e6695),
            500: Color(0xff1c4b82),
            600: Color(0xFF19447a),
            700: Color(0xFF143b6f),
            800: Color(0xFF113365),
            900: Color(0xFF092352),
          },
        ),
        accentColor: MaterialAccentColor(0xff2164ff,  <int, Color>{
          100: Color(0xFF87abff),
          200: Color(0xFF5488ff),
          400: Color(0xFF2164ff),
          700: Color(0xFF0852ff),
        }),
        primaryColorBrightness: Brightness.dark
      ),
      home: SplashModule()
    );
  }
}
