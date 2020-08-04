import 'package:flutter/material.dart';

import 'package:news_example_app/screens/feed/model/post_access_controller.dart';

/*
  The superior part of the post, containing datetime info.
*/
class PostHeader extends StatelessWidget {
  const PostHeader({
    Key key,
    @required this.pac,
  }) : super(key: key);

  final PostAccessController pac;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[Text(this.pac.post.getDateFormated())],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
      padding: EdgeInsets.all(10.0),
    );
  }
}
