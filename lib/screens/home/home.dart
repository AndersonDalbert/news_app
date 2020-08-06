import 'package:flutter/material.dart';

import 'package:news_example_app/screens/feed/feed.dart';
import 'package:news_example_app/screens/profile/profile.dart';

/*
  Entrance of the restricted area of application. Builds a nav bar and its
  children.
*/
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentNavIndex = 0;
  List<Widget> _navChildren = [
    Feed(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: _navChildren[_currentNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentNavIndex,
            onTap: onTabTapped,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            backgroundColor: Theme.of(context).primaryColor,
            items: _buildNavItems(),
          )),
    );
  }

  void onTabTapped(int navIndex) {
    setState(() {
      _currentNavIndex = navIndex;
    });
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.rss_feed),
        title: Text('Notícias'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('Perfil'),
        backgroundColor: Colors.blue,
      ),
    ];
  }
}
