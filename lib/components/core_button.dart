import 'package:flutter/material.dart';

/*
  Default large buttom for application.
 */
class CoreButton extends StatelessWidget {
  final Color color;
  final String description;
  final Function function;
  final double width;

  CoreButton(this.color, this.description, this.function, {this.width});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: this.width == null ? 40 : this.width,
      child: RaisedButton(
          color: this.color,
          highlightColor: Colors.blueGrey,
          highlightElevation: 5,
          child: Text(
            this.description,
            style: TextStyle(fontFamily: 'Poppins-Medium', color: Colors.white),
          ),
          onPressed: this.function),
    );
  }
}
