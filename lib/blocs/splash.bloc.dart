import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:news_example_app/model/user.dart';
import 'package:news_example_app/services/user_service.dart';

class SplashBloc {
  /*
    This method accesses the FirebaseAuth instance to build an User model,
    shared through the application.
  */
  Future<UserModel> buildUserModel(BuildContext context) async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    assert(firebaseUser != null);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userKey = _generateKey(firebaseUser.uid);
    Map<String, dynamic> userJson;
    // recupera o objeto serializado, caso ele esteja salvo em SharedPreferences
    if (prefs.containsKey(userKey) && prefs.getString(userKey) != "null") {
      String userString = prefs.getString(userKey);
      userJson = jsonDecode(userString);
    }
    // caso contrário, chama a API do firebase para acessar dados do usuário e salva nas shared prefs
    else {
      userJson = await UserService.getUserInfo(firebaseUser.uid);
      String userString = jsonEncode(userJson);
      prefs.setString(userKey, userString);
    }
    return UserModel.fromJson(userJson);
  }

  String _generateKey(String uid) => '$uid/userData';
}
