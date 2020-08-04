import 'package:flutter/material.dart';
import 'package:news_example_app/model/user.dart';
import 'package:news_example_app/services/login_service.dart';
import 'package:provider/provider.dart';

import './components/info_tile.dart';
import './components/header.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ProfileHeader(
            userName: user.name,
            profileImageUrl: user.profileImageUrl,
          ),
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  InfoTile(text: user.email, icon: Icons.email),
                  SizedBox(height: 15),
                  FlatButton(
                    onPressed: () => LoginService.logOut(),
                    child: Text('Log out'),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
