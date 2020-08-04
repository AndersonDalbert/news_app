import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:news_example_app/model/post.dart';
import 'package:news_example_app/screens/feed/model/post_access_controller.dart';
import 'clickable_post.dart';
import 'post_footer.dart';

/*
  This class wraps the elements displayed in the feed. Each element is a 
  resume of the post.
*/
class PostResume extends StatefulWidget {
  final Post post;

  PostResume({this.post});

  @override
  _PostResumeState createState() => _PostResumeState();
}

class _PostResumeState extends State<PostResume> {
  @override
  Widget build(BuildContext context) {
    final PostAccessController pac = new PostAccessController(widget.post);

    return Card(
        color: Colors.grey.shade50,
        child: Column(children: <Widget>[
          ClickablePost(pac),
          PostFooter(pac),
          SizedBox(height: 20)
        ]));
  }
}
