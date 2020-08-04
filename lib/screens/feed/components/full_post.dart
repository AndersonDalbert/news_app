import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_example_app/screens/feed/model/post_access_controller.dart';

import 'post_footer.dart';
import 'post_header.dart';

/*
  Page showing the full post, with the whole body content.
*/
class FullPost extends StatelessWidget {
  final PostAccessController pac;

  FullPost(this.pac);

  @override
  Widget build(BuildContext context) {
    String title = pac.post.title;
    String body = pac.post.body;
    String imageUrl = pac.post.imageUrl;

    return (Scaffold(
        appBar: AppBar(
          title: Text("Detalhes da postagem"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PostFooter(pac),
        ),
        body: Container(
            color: Colors.grey.shade50,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  PostHeader(pac: this.pac),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: imageUrl != null
                        ? CoverImage(pac: pac, imageUrl: imageUrl)
                        : SizedBox(),
                  ),
                  Container(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.all(10.0)),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(body,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify),
                  ),
                ],
              ),
            ))));
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key key,
    @required this.pac,
    @required this.imageUrl,
  }) : super(key: key);

  final PostAccessController pac;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(
          text: this.pac.post.imageUrl,
        ));
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Link da imagem copiado"),
        ));
      },
      child: Image.network(imageUrl),
    );
  }
}
