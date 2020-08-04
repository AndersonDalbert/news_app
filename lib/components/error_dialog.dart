import 'package:flutter/material.dart';

/*
  An default error dialog with custom message and close buttom.
*/
class ErrorDialog extends StatelessWidget {
  final String message;

  ErrorDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Erro"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("Fechar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
