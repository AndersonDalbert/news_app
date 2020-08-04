import 'package:news_example_app/model/post.dart';
import 'package:news_example_app/services/feed_service.dart';
import 'package:news_example_app/services/user_service.dart';

/*
  This class is used for encapsulate the logic used in Feed. Contains a Post
  model, a UserService and a FeedService.
*/
class PostAccessController {
  UserService us;
  FeedService ps;
  Post post;

  PostAccessController(Post post) {
    this.post = post;
    this.us = new UserService();
    this.ps = new FeedService();
  }

  Future<int> getLikes() async {
    return await FeedService.getNumberOfLikes(this.post.postId);
  }
}
