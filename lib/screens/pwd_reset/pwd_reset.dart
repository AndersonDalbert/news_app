import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_example_app/components/edit_form.dart';
import 'package:news_example_app/components/error_dialog.dart';
import 'package:news_example_app/components/validators.dart';
import 'package:news_example_app/components/core_button.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordResetPage();
}

class _PasswordResetPage extends State<PasswordResetPage> {
  final GlobalKey<FormState> _resetPwdFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;

  @override
  void initState() {
    super.initState();
    emailInputController = new TextEditingController();
  }

  Future<void> _resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog("Verifique novamente o e-mail inserido.");
          });
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("E-mail enviado"),
              content: Text(
                  "Enviamos um e-mail de alteração de senha para o endereço informado. Verifique a sua caixa de entrada."),
              actions: <Widget>[
                FlatButton(
                    child: Text("Fechar"),
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar senha"),
      ),
      body: Container(
          margin: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _resetPwdFormKey,
              child: Column(children: <Widget>[
                SizedBox(height: 10),
                Text("Digite o e-mail cadastrado:"),
                SizedBox(height: 10),
                CustomTextForm(Icons.email, 'E-mail',
                    controller: emailInputController,
                    validator: Validators.emailValidator,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: 20),
                CoreButton(Theme.of(context).primaryColor,
                    "Enviar e-mail de recuperação", () async {
                  final state = _resetPwdFormKey.currentState;
                  if (state.validate()) {
                    _resetPassword(emailInputController.text, context);
                  }
                })
              ]),
            ),
          )),
    );
  }
}
