
import 'package:example/categories/categories_ui.dart';
import 'package:example/categories/utilities.dart';
import 'package:example/leaderBoard.dart';
import 'package:example/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const snackBarDuration = Duration(seconds: 3);

  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Press back again to exit'),
    duration: snackBarDuration,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backButtonPressTime;
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

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    SystemNavigator.pop();
    return true;
  }

  SharedPrefs sharedPrefs = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: PageView(
            // physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              Container(
                child: ButtonImplementation(sharedPrefs),
              ),
              Container(child: Leader()),
              Container(child: Settings())
            ],
          ),
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
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String label, int number) {
    return BottomNavigationBarItem(
      icon: Icon(
          number == 0
              ? Icons.home
              : number == 1 ? Icons.dashboard : Icons.account_circle,
          color: _page == number ? Colors.blue : Colors.grey),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: _page == number ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
