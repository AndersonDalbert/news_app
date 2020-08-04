import 'package:flutter/cupertino.dart';

/*
  Model for a user. Uses a mixin with ChangeNotifier to grant that alterations
  to the model reflects in the listeners.
*/
class UserModel with ChangeNotifier {
  String _uid, _name, _email, _profileImageUrl;

  UserModel(this._uid, this._name, this._email,
      {profileImageUrl = "assets/user.jpg"}) {
    _profileImageUrl = profileImageUrl;
  }

  get uid => this._uid;
  get name => this._name;
  get email => this._email;
  get profileImageUrl => this._profileImageUrl;

  set name(String newName) {
    this.name = newName;
    notifyListeners();
  }

  set profileImageUrl(String newProfileImageUrl) {
    this._profileImageUrl = newProfileImageUrl;
    notifyListeners();
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : _uid = json['uid'],
        _email = json['email'],
        _name = json['name'],
        _profileImageUrl = json['profileImageUrl'];

  Map<String, dynamic> toJson() => {
        'name': _name,
        'email': _email,
        'uid': _uid,
        'profileImageUrl': _profileImageUrl
      };
}
