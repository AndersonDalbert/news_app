import 'package:flutter/material.dart';

import 'package:news_example_app/theme.dart';
import 'package:news_example_app/routes.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

class LocalAppMaterial extends StatelessWidget {
  final Widget homePage;

  LocalAppMaterial(
    this.homePage, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example News App',
      theme: appTheme,
      home: homePage,
      routes: routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
    );
  }
}
