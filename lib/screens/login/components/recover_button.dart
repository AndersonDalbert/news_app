import 'package:flutter/material.dart';

class RecoverButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Align(
        child: InkWell(
          child: Text('Recuperar Senha',
              style: TextStyle(
                  color: Colors.black, decoration: TextDecoration.underline)),
        ),
      ),
    );
  }
}
