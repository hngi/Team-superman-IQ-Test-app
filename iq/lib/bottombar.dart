
import 'package:example/categories/categories_ui.dart';
import 'package:example/categories/utilities.dart';
import 'package:example/leaderBoard.dart';
import 'package:example/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  PageController _pageController;
  int _page = 0;

  String uid;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }


  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void _bottomTapped(int page) {
    _pageController.jumpToPage(page);
  }

  SharedPrefs sharedPrefs = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
          child: SafeArea(
                      child: Scaffold(
            // backgroundColor: Colors.white,
            body: PageView(
              // physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: <Widget>[
                Container(child: ButtonImplementation(sharedPrefs),
                ),
                Container(child: Leader()),
                Container(child: Settings())
              ],
            ),
            bottomNavigationBar: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CupertinoTabBar(
                  
                  onTap: _bottomTapped,
                  currentIndex: _page,
                  backgroundColor: Colors.transparent,
                  items: <BottomNavigationBarItem>[
                    _bottomNavigationBarItem("Home", 0),
                    _bottomNavigationBarItem("Scores", 1),
                    _bottomNavigationBarItem("Settings", 2),
                  ],
                ),
              ),
            ),
      ),
          ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String label, int number) {
    return BottomNavigationBarItem(
      
      icon: Icon(
        number == 0 ? Icons.home : number == 1 ? Icons.dashboard : Icons.account_circle,
        color: _page == number
            ? Colors.blue
            : Colors.grey
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: _page == number
              ? Colors.blue
              : Colors.grey,
        ),
      ),
    );
  }

 
}
