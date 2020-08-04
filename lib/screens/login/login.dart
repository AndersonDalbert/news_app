import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:news_example_app/components/loading.dart';
import 'package:news_example_app/services/login_service.dart';
import 'components/dont_have_acess.dart';
import 'components/forgot_password.dart';
import '../../components/edit_form.dart';
import '../../components/validators.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    super.initState();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Container(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                  child: Form(
                key: _loginFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Image.asset('assets/newspaper.png', height: 200),
                      SizedBox(height: 15),
                      CustomTextForm(
                        Icons.email,
                        'e-mail',
                        controller: emailInputController,
                        validator: Validators.emailValidator,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10),
                      CustomTextForm(Icons.lock, 'senha',
                          obscureText: true,
                          controller: pwdInputController,
                          validator: Validators.pwdValidator),
                      SizedBox(height: 10),
                      buildButtonTheme(context),
                      SizedBox(height: 4),
                      Text("ou"),
                      SizedBox(height: 4),
                      SignInButton(
                        Buttons.GoogleDark,
                        onPressed: () => _loginwithGoogle(context),
                        text: "Entrar com Google",
                      ),
                      Divider(),
                      DontHaveAccessComponent(),
                      SizedBox(height: 12),
                      ForgotPasswordComponent(),
                    ]),
              )),
            ),
          )),
    );
  }

  ButtonTheme buildButtonTheme(BuildContext context) {
    return ButtonTheme(
      minWidth: 220,
      height: 35,
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          highlightColor: Colors.blueGrey,
          highlightElevation: 5,
          child: Text(
            "Entrar",
            style: TextStyle(fontFamily: 'Poppins-Medium', color: Colors.white),
          ),
          onPressed: () {
            if (_loginFormKey.currentState.validate()) {
              _loginWithEmail(context);
            }
          }),
    );
  }

  void _loginWithEmail(BuildContext context) async {
    _showLoadingDialog(context);

    // checks if there is a signed user. if it does, logout first.
    final firebaseAuth = FirebaseAuth.instance;
    final currentUser = await firebaseAuth.currentUser();
    if (currentUser != null) await LoginService.logOut();

    // sign in and deals with loading modal
    try {
      await LoginService.emailLogin(
          emailInputController.text, pwdInputController.text);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      await _showLoginErrorDialog(context);
    }
  }

  void _loginwithGoogle(BuildContext context) async {
    //  _showLoadingDialog(context);
    await LoginService.googleLogin().catchError((_) {
      // Navigator.pop(context);
      _showLoginErrorDialog(context);
      return;
    }).then((_) {
      // runApp(MyApp());
    });
  }

  Future _showLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (bc) {
          return Scaffold(
              body: Align(alignment: Alignment.center, child: Loading()));
        });
  }

  Future<void> _showLoginErrorDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (bc) {
          return AlertDialog(
            title: Text("Erro no login"),
            content: Text(
                "Erro no login. Verifique suas credenciais ou sua conexão com a internet"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen())),
                child: Text("Voltar"),
              )
            ],
          );
        });
  }
}
