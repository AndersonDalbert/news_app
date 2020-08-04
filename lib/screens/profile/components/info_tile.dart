import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    Key key,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 15),
          Icon(icon),
          SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: VerticalDivider(),
          ),
          SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
