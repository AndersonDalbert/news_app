import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:news_example_app/screens/login/login.dart';
import 'package:news_example_app/screens/splash/components/local_material_app.dart';
import 'package:news_example_app/screens/splash/components/user_provider.dart';
import 'blocs/splash.bloc.dart';
import 'screens/confirm_email/confirm_email.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/splash/components/error.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = SplashBloc();
    return _getLandingPage(bloc);
  }

  /*
    Builds app landing page according to stream's connection state.
  */
  Widget _getLandingPage(SplashBloc bloc) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, authSnapshot) {
        switch (authSnapshot.connectionState) {
          case ConnectionState.active:
            return _checkIsVerifiedAndBuildUser(authSnapshot, bloc);
            break;

          case ConnectionState.waiting:
            return LocalAppMaterial(SplashPage());

          default:
            return LocalAppMaterial(Error());
        }
      },
    );
  }

  /*
    Verify if user account is already verified.
  */
  Widget _checkIsVerifiedAndBuildUser(
      AsyncSnapshot<FirebaseUser> authSnapshot, bloc) {
    // checks if snapshot has data to avoid null pointer
    if (authSnapshot.hasData) {
      final bool isVerified = authSnapshot.data.isEmailVerified;
      // if user is not verified, shows verify email page
      if (isVerified == false)
        return LocalAppMaterial(VerifyEmailPage(authSnapshot.data));
      // else continues with navigation
      else
        return UserProvider(bloc: bloc);
    } else {
      return LocalAppMaterial(LoginScreen());
    }
  }
}
