import 'package:flutter/material.dart';
import 'package:news_example_app/screens/splash/components/local_material_app.dart';

import 'package:provider/provider.dart';

import 'package:news_example_app/blocs/splash.bloc.dart';
import 'package:news_example_app/model/user.dart';
import 'package:news_example_app/screens/home/home.dart';
import 'package:news_example_app/screens/login/components/login_error_page.dart';
import 'package:news_example_app/screens/splash/splash_screen.dart';

class UserProvider extends StatelessWidget {
  const UserProvider({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final SplashBloc bloc;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: bloc.buildUserModel(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ChangeNotifierProvider<UserModel>(
                  create: (context) => snapshot.data,
                  child: LocalAppMaterial(Home()),
                );
              }
              return LocalAppMaterial(LoginErrorPage());

            default:
              return LocalAppMaterial(SplashPage());
          }
        });
  }
}
