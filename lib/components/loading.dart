import 'package:flutter/material.dart';

/*
  A container with a text and a circular progress indicator for displaying 
  while loading stuff.
*/
class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 150,
          color: Colors.white,
          margin: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text('Carregando...')
            ],
          ),
        ),
      ),
    );
  }
}
