import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  final FirebaseUser _user;
  VerifyEmailPage(this._user);

  get _getMaskedEmail {
    String domain = _user.email.split('@')[1];
    return _user.email.substring(0, 5) + "...@" + domain;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12),
        child: ListView(children: <Widget>[
          SizedBox(height: 20),
          Center(
              child: Text(
            "Verifique seu e-mail",
            style: Theme.of(context).textTheme.headline1,
          )),
          SizedBox(height: 20),
          Center(child: Image.asset('assets/mailbox.png')),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
                text: 'Confirme o seu e-mail ',
                style: Theme.of(context).textTheme.bodyText2,
                children: <TextSpan>[
                  TextSpan(
                      text: '$_getMaskedEmail',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' para acessar nosso aplicativo! ')
                ]),
          ),
        ]),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_backToLoginButton(context), _verifyEmailButton(context)],
      ),
    );
  }

  Widget _backToLoginButton(BuildContext context) {
    return FlatButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: Text(
          "Voltar",
          style: TextStyle(color: Colors.grey),
        ));
  }

  Widget _verifyEmailButton(BuildContext context) {
    return ButtonTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            'Enviar e-mail',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => _sendVerificationEmail(context),
        ));
  }

  /*
    Displays loading dialog while sending verification email.
  */
  _sendVerificationEmail(BuildContext context) async {
    _showLoadingDialog(context);
    await _user.sendEmailVerification().then((_) => Navigator.pop(context));
    _showSuccessDialog(context);
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('E-mail enviado com sucesso'),
            content: Text('Verifique sua caixa de entrada'),
            actions: <Widget>[
              FlatButton(
                child: Text("Fechar"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
                width: 15,
                height: 15,
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )),
          );
        });
  }
}
