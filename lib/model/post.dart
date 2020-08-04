import 'package:intl/intl.dart';

/*
  Model for a post.
*/
class Post {
  String _postId, _title, _body, _postUrl, _imageUrl;
  DateTime _date;

  Post(
    this._postId,
    this._postUrl,
    this._title,
    this._body,
    this._imageUrl,
    this._date,
  );

  Post.fromJson(Map<String, dynamic> json)
      : _postId = json["postId"],
        _title = json["title"],
        _date = json["date"].toDate(),
        _body = json["body"],
        _imageUrl = json["image_url"],
        _postUrl = json["web_post_url"];

  get postId => this._postId;

  get title => this._title;

  get body => this._body;

  get postUrl => this._postUrl;

  get imageUrl => this._imageUrl;

  get date => this._date;

  String getDateFormated() {
    return DateFormat("dd/MM/yyyy kk:mm").format(this.date);
  }
}
