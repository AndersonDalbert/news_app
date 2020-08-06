import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_example_app/components/header.dart';
import 'package:news_example_app/components/loading.dart';
import 'package:news_example_app/model/post.dart';

import 'components/post_resume.dart';

class Feed extends StatefulWidget {
  const Feed();

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  final _db = Firestore.instance;
  List<Post> _postList;
  var _noMore = false;
  var _isFetching = false;
  DocumentSnapshot _lastDocument;
  ScrollController _controller;
  static const _INITIAL_POSTS_LIMIT = 2;
  static const _LOAD_POSTS_LIMIT = 4;

  @override
  void initState() {
    _fetchDocuments();
    _controller = ScrollController()..addListener(_scrollListener);
    _postList = List<Post>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (_noMore) return;
    if (_controller.position.pixels == _controller.position.maxScrollExtent &&
        _isFetching == false) {
      _isFetching = true;
      await _fetchFromLast();
      _isFetching = false;
    }
  }

  Future<void> _fetchDocuments() async {
    setState(() {
      _isFetching = true;
    });
    QuerySnapshot snapshots = await _db
        .collection('posts')
        .orderBy('date', descending: true)
        .limit(_INITIAL_POSTS_LIMIT)
        .getDocuments();
    _lastDocument = snapshots.documents.last;
    snapshots.documents.forEach((snapshot) {
      _postList.add(Post.fromJson(snapshot.data));
    });
    setState(() {
      _isFetching = false;
    });
    return;
  }

  Future _fetchFromLast() async {
    final QuerySnapshot querySnapshot = await _db
        .collection('posts')
        .orderBy('date', descending: true)
        .startAfter([_lastDocument['date']])
        .limit(_LOAD_POSTS_LIMIT)
        .getDocuments();
    final length = querySnapshot.documents.length;
    if (length < _LOAD_POSTS_LIMIT) {
      _noMore = true;
    }
    if (length == 0) return;
    _lastDocument = querySnapshot.documents.last;
    for (final DocumentSnapshot snapshot in querySnapshot.documents) {
      final Post post = Post.fromJson(snapshot.data);
      setState(() {
        _postList.add(post);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isFetching
        ? Scaffold(body: Loading())
        : ListView(
            children: <Widget>[
              Header(
                child: Center(
                    child: Text(
                  "Notícias",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white, fontSize: 50),
                )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Últimas notícias",
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(height: 8),
              _buildScrollView(),
            ],
          );
  }

  Widget _buildScrollView() {
    return Container(
      color: Colors.grey.shade200,
      child: Scrollbar(
          controller: _controller,
          child: ListView.builder(
            shrinkWrap: true,
            controller: _controller,
            itemCount: _postList.length,
            itemBuilder: (context, index) => _buildFeedElement(index),
          )),
    );
  }

  PostResume _buildFeedElement(int index) {
    Post post = _postList[index];
    return PostResume(post: post);
  }
}
