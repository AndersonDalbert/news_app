import 'package:flutter/material.dart';

/*
  A custom TextFormField for application wrapped inside a container to give it
  custom borders.
*/
class CustomTextForm extends StatelessWidget {
  CustomTextForm(this.icon, this.hintText,
      {this.obscureText, this.validator, this.keyboardType, this.controller});

  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Function validator;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.elliptical(4.0, 3.0)),
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: Row(children: <Widget>[
        SizedBox(width: 5),
        Icon(this.icon, color: Theme.of(context).primaryColor),
        SizedBox(width: 10),
        Flexible(
            child: TextFormField(
          obscureText: this.obscureText == null ? false : true,
          validator: this.validator,
          keyboardType: this.keyboardType == null
              ? TextInputType.text
              : this.keyboardType,
          controller: this.controller,
          decoration: InputDecoration.collapsed(
            hintText: this.hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        )),
      ]),
    );
  }
}
