import 'package:flutter/material.dart';
import 'package:news_example_app/components/header.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
    @required this.userName,
    @required this.profileImageUrl,
  }) : super(key: key);

  final String profileImageUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Header(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Center(
                child: _buildCircleAvatar(profileImageUrl),
              ),
              SizedBox(height: 15),
              Text(
                userName,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
              color: Colors.white, icon: Icon(Icons.edit), onPressed: () {}),
        ),
      ],
    );
  }

  CircleAvatar _buildCircleAvatar(String photoUrl) {
    return CircleAvatar(
      radius: 70.0,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(photoUrl),
    );
  }
}
