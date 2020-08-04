import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'package:news_example_app/components/error_dialog.dart';
import 'package:news_example_app/model/user.dart';
import 'package:news_example_app/screens/feed/model/post_access_controller.dart';
import 'package:news_example_app/services/feed_service.dart';

class PostFooter extends StatefulWidget {
  const PostFooter(this.pac, {Key key}) : super(key: key);

  final PostAccessController pac;

  @override
  State<StatefulWidget> createState() {
    return _PostFooterState();
  }
}

class _PostFooterState extends State<PostFooter> {
  bool isFetching = false;
  bool userLiked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<UserModel>(context, listen: false).uid;
    return _buildFooter(uid);
  }

  Widget _buildFooter(String uid) {
    final postSnapshots = Firestore.instance
        .collection('posts')
        .document(widget.pac.post.postId)
        .snapshots();
    return StreamBuilder(
      stream: postSnapshots,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            if (!snapshot.hasData)
              return ErrorDialog("Falha ao carregar informações da postagem");
            bool userDidLiked = haveUserLiked(snapshot, uid);
            return Footer(
              userDidLiked: userDidLiked,
              widget: widget,
              uid: uid,
              snapshot: snapshot.data,
            );

          default:
            return PlaceholderFooter(widget: widget);
        }
      },
    );
  }

  bool haveUserLiked(AsyncSnapshot snapshot, String uid) {
    return List.from(snapshot.data['usersWhoLiked']).contains(uid);
  }
}

class PlaceholderFooter extends StatelessWidget {
  const PlaceholderFooter({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final PostFooter widget;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(children: <Widget>[
            ImageIcon(AssetImage("assets/heart-icon.png"), color: Colors.grey),
            SizedBox(width: 8),
            Text(" ")
          ]),
          Footer.buildShareButton(
              widget.pac.post.postUrl, widget.pac.post.title)
        ]);
  }
}

class Footer extends StatelessWidget {
  const Footer(
      {Key key,
      @required this.userDidLiked,
      @required this.widget,
      @required this.snapshot,
      @required this.uid})
      : super(key: key);

  final bool userDidLiked;
  final PostFooter widget;
  final String uid;
  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(children: <Widget>[
            InkWell(
              child: ImageIcon(AssetImage("assets/heart-icon.png"),
                  color: userDidLiked ? Colors.red : Colors.grey),
              onTap: () async =>
                  await FeedService.likeAction(uid, widget.pac.post.postId),
            ),
            SizedBox(width: 8),
            Text(
              List.from(snapshot.data['usersWhoLiked']).length.toString(),
            )
          ]),
          buildShareButton(widget.pac.post.imageUrl, widget.pac.post.title)
        ]);
  }

  static InkWell buildShareButton(String imageUrl, String postTitle) {
    return InkWell(
      child: Row(children: <Widget>[
        Icon(Icons.share),
        SizedBox(width: 5),
        Text("Compartilhar")
      ]),
      onTap: () => _share(postTitle),
    );
  }

  static _share(String postTitle) {
    Share.share('Confira essa notícia: "$postTitle"\nBaixe já o app.');
  }
}
