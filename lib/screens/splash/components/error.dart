import 'package:flutter/material.dart';
import 'package:news_example_app/components/error_dialog.dart';

class Error extends StatelessWidget {
  const Error({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorDialog('Não foi possível conectar-se com o servidor.'),
    );
  }
}
