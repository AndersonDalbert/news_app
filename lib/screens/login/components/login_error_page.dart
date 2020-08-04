import 'package:flutter/material.dart';
import 'package:news_example_app/components/core_button.dart';
import 'package:news_example_app/services/login_service.dart';

/*
  Builds a page to display when user auth information doesn't corresponde to
  user data saved in Firestore.
 */
class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Erro de login",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 10),
            Text(
              "Não foi possível recuperar informações de usuário. Talvez você tenha tentado fazer login sem ter previamente se registrado.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            CoreButton(
              Theme.of(context).primaryColor,
              "Ir para registro",
              () async => Navigator.of(context).pushNamed('/register'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text('ou'),
            ),
            Center(
                child: FlatButton(
                    onPressed: () => LoginService.logOut(),
                    child: Text('Voltar')))
          ],
        ),
      )),
    );
  }
}
