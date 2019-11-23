import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pocket_gtd/app/pages/splash/splash_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket GTD',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      localeResolutionCallback:
          S.delegate.resolution(fallback: new Locale("en", "US")),
      theme: ThemeData(
          primarySwatch: MaterialColor(
            0XFF07689f,
            <int, Color>{
              50: Color(0xFFCAF4FA),
              100: Color(0xFFCAF4FA),
              200: Color(0xFF97E4F5),
              300: Color(0xFF60C3E2),
              400: Color(0xFF379AC5),
              500: Color(0XFF07689f),
              600: Color(0xFF055088),
              700: Color(0xFF033C72),
              800: Color(0xFF022A5C),
              900: Color(0xFF011E4C),
            },
          ),
        accentColor: MaterialAccentColor(0xFF4F6CFF,  <int, Color>{
          100: Color(0xFFEDFCFE),
          200: Color(0xFFDCF7FD),
          400: Color(0xFFB9E4F7),
          700: Color(0xFF5181AE),
        }),
        primaryColorBrightness: Brightness.dark
      ),
      home: SplashModule()
    );
  }
}
