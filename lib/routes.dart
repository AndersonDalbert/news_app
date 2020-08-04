import 'package:flutter/widgets.dart';
import 'package:news_example_app/screens/login/login.dart';
import 'package:news_example_app/screens/register/register.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/login': (BuildContext context) => LoginScreen(),
  '/register': (BuildContext context) => RegisterPage()
};
