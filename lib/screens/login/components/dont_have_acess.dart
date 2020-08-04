import 'package:flutter/material.dart';
import 'package:news_example_app/screens/register/register.dart';

class DontHaveAccessComponent extends StatelessWidget {
  const DontHaveAccessComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'Não tem acesso? ',
        style: TextStyle(fontSize: 16),
      ),
      InkWell(
        child: Text('Registre-se',
            style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline)),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
      )
    ]);
  }
}
