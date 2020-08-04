import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_example_app/screens/feed/model/post_access_controller.dart';

import 'full_post.dart';
import 'post_header.dart';

/*
  A post resume wrapped out with an Inkwell to grant navigation.
*/
class ClickablePost extends StatelessWidget {
  const ClickablePost(this.pac, {Key key}) : super(key: key);

  final PostAccessController pac;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Column(
          children: <Widget>[
            PostHeader(pac: pac),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: this.pac.post.imageUrl != null
                  ? CachedNetworkImage(
                      placeholder: (context, url) => CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                      imageUrl: this.pac.post.imageUrl)
                  : SizedBox(),
            ),
            Container(
                child: Text(
                  this.pac.post.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.all(10.0)),
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                this.pac.post.body,
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullPost(this.pac),
                ),
              )
            });
  }
}
