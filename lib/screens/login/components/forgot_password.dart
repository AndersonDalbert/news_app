import 'package:flutter/material.dart';
import '../../pwd_reset/pwd_reset.dart';

class ForgotPasswordComponent extends StatelessWidget {
  const ForgotPasswordComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'Esqueceu a senha? ',
        style: TextStyle(fontSize: 16),
      ),
      InkWell(
        child: Text('Recuperar senha',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            )),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PasswordResetPage()));
        },
      )
    ]);
  }
}
