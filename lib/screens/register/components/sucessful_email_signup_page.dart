import 'package:flutter/material.dart';
import 'package:news_example_app/components/core_button.dart';

class SuccessfulEmailSignupPage extends StatelessWidget {
  const SuccessfulEmailSignupPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Sucesso!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    'Conta criada com sucesso. Faça login para acessar nosso app.'),
                SizedBox(height: 20),
                CoreButton(Theme.of(context).primaryColor, "Fazer login",
                    () => Navigator.pushNamed(context, "/login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
