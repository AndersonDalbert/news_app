import 'package:flutter/material.dart';
import 'package:news_example_app/components/edit_form.dart';
import 'package:news_example_app/components/error_dialog.dart';
import 'package:news_example_app/components/loading.dart';
import 'package:news_example_app/components/validators.dart';
import 'package:news_example_app/services/login_service.dart';
import 'package:news_example_app/services/register_service.dart';

class EmailSignupPage extends StatefulWidget {
  @override
  _EmailSignupPageState createState() => _EmailSignupPageState();
}

class _EmailSignupPageState extends State<EmailSignupPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController nameInputController,
      emailInputController,
      pwdInputController,
      confirmPwdInputController,
      cpfInputController;

  @override
  initState() {
    super.initState();
    nameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro via e-mail")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _registerFormKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              Text('Registre-se via e-mail',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Poppins-Medium')),
              SizedBox(height: 10),
              CustomTextForm(Icons.person, 'Nome',
                  controller: nameInputController,
                  keyboardType: TextInputType.text),
              SizedBox(height: 10),
              CustomTextForm(Icons.email, 'E-mail',
                  controller: emailInputController,
                  validator: Validators.emailValidator,
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10),
              CustomTextForm(Icons.lock, 'Senha',
                  controller: pwdInputController,
                  validator: Validators.pwdValidator,
                  obscureText: true),
              SizedBox(height: 10),
              CustomTextForm(Icons.lock, 'Confirmar senha',
                  obscureText: true, controller: confirmPwdInputController),
              SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text('Fazer cadastro'),
                        onPressed: () => _cadastrar()),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _registerUser() async {
    final state = _registerFormKey.currentState;
    if (!state.validate()) return false;
    if (pwdInputController.text != confirmPwdInputController.text) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog("As senhas precisam ser iguais"));
      return false;
    }
    try {
      await RegisterService.registerWithEmail(nameInputController.text,
          emailInputController.text, pwdInputController.text);
      return true;
    } catch (error) {
      print(error.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(error.toString());
          });
    }
    return false;
  }

  @override
  void dispose() {
    if (_registerFormKey.currentState != null)
      _registerFormKey.currentState.reset();
    super.dispose();
  }

  _cadastrar() async {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(body: Loading());
        });
    bool success = await _registerUser();
    Navigator.pop(context);
    Navigator.pop(context);
    if (success) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Cadastro concluído"),
                content: Text(
                    "Enviamos um e-mail de confirmação para o e-mail cadastrado. Confirme seu e-mail e já poderá fazer login na tela inicial."),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text("Fazer login"))
                ],
              ));
      LoginService.logOut();
    } else
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              "Ocorreu um erro ao fazer seu cadastro. Tente novamente."));
  }
}
