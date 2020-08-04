import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:news_example_app/components/error_dialog.dart';
import 'package:news_example_app/components/loading.dart';
import 'package:news_example_app/services/register_service.dart';
import 'components/email_signup.dart';
import 'components/sucessful_email_signup_page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registre-se'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo(a).',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 30),
            SignInButton(
              Buttons.Google,
              onPressed: () => _googleSignup(context),
              text: "Registre-se via Google",
            ),
            SizedBox(height: 10),
            Text('ou'),
            SizedBox(height: 10),
            SignInButton(
              Buttons.Email,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmailSignupPage())),
              text: "Registre-se via e-mail",
            ),
            SizedBox(height: 5),
            Divider(),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Já possui cadastro? "),
                InkWell(
                    child: Text("Faça login.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                    onTap: () =>
                        Navigator.popUntil(context, (route) => route.isFirst))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _googleSignup(context) async {
    _showLoadingDialog(context);
    bool success = await RegisterService.registerWithGoogle();
    Navigator.pop(context);
    if (success)
      _showSuccessDialog(context);
    else
      _showFailureDialog(context);
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(body: Loading());
        });
  }

  void _showFailureDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog("Erro ao fazer registro. Tente novamente.");
        });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SuccessfulEmailSignupPage();
        });
  }
}
