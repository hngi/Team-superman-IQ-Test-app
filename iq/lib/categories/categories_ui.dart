import 'package:example/constants/colors.dart';
import 'package:example/constants/strings.dart';
import 'package:example/constants/textStyles.dart';
import 'package:example/core/quiz_page.dart';
import 'package:example/state/theme.dart';
import 'package:example/state/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'utilities.dart';
import 'dart:math';

class ButtonImplementation extends StatefulWidget {
  final SharedPrefs sharedPrefs;
  ButtonImplementation(this.sharedPrefs);
  @override
  _ButtonImplementationState createState() => _ButtonImplementationState();
}

class _ButtonImplementationState extends State<ButtonImplementation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPrefs prefs;
  bool isTimed = false;
  var key = "nil";
  String category;
  String element;

  static final _random = Random();

  String username;

  void getName() async {
    String name = await prefs.getname();
    bool timed = await prefs.getIsTimed();
    setState(() {
      username = name;
      isTimed = timed;
    });
  }

  @override
  void initState() {
    prefs = widget.sharedPrefs;
    getName();
    var _element = quote[_random.nextInt(quote.length)];
    setState(() {
      element = _element;
    });
    super.initState();
  }

  checkIsTimed(bool value) {
    value ? prefs.setIsTimed(true) : prefs.setIsTimed(false);
  }

  var _darkTheme;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // _profileIcon(),
              SizedBox(height: 20),
              _welcomeText(),
              SizedBox(height: 10),
              _quoteBlock(height, width),
              SizedBox(height: 10.0),
              _textSelectCategory(),
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: width,
                        height: height,
                        child: GridView.count(
                          crossAxisCount: 2,
                          padding: const EdgeInsets.only(right: 18, left: 18),
                          children: <Widget>[
                            CategoryOptions(title: 'Easy'),
                            CategoryOptions(title: 'Moderate'),
                            CategoryOptions(title: 'Hard'),
                          ],
                        ),
                      ),
                    ),
                    _timer(height, width),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timer(height, width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: <Widget>[
              Text(
                'Timer',
                style: TextStyle(
                    color: _darkTheme ? Colors.green : Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Switch(
                onChanged: (value) {
                  setState(() {
                    isTimed = value;

                    checkIsTimed(isTimed);
                  });
                },
                value: isTimed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _welcomeText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: Column(
        children: <Widget>[
          _texGreeting(),
          _textWelcome(),
        ],
      ),
    );
  }

  Widget _quoteBlock(height, width) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: height * .13,
        width: width,
        decoration: BoxDecoration(
          color: blue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(child: _textQuote()),
        ),
      ),
    );
  }

  Widget _textSelectCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            selectACategory,
            style: selectCategory,
          ),
        ],
      ),
    );
  }

  Widget _textWelcome() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          textWelcome,
          style: greetingStyle,
        ),
      ],
    );
  }

  Widget _texGreeting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
              text: textGreeting,
              style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: _darkTheme ? Colors.white : Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: username != null ? username + '!' : playerName,
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: _darkTheme ? Colors.white : Colors.black),
                )
              ]),
        ),
      ],
    );
  }

  Widget _textQuote() {
    return Text(
      element,
      style: quoteStyle,
    );
  }

  Widget _textQuoteAuthor() {
    return Text(
      quoteAuthor,
      style: quoteAuthorStyle,
    );
  }

  Widget _profileIcon() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Icon(
              Icons.account_circle,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryOptions extends StatefulWidget {
  final String title;
  final GestureTapCallback onTap;

  const CategoryOptions({
    Key key,
    @required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  _CategoryOptionsState createState() => _CategoryOptionsState();
}

class _CategoryOptionsState extends State<CategoryOptions> {
  SharedPrefs prefs = SharedPrefs();
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Expanded(
          child: InkWell(
            onTap: () async {
              bool timed = await prefs.getIsTimed();
              print(timed);
              if (widget.title == 'Easy') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage(
                              timed: timed,
                              category: 'Easy',
                            )));
              } else if (widget.title == 'Moderate') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage(
                              timed: timed,
                              category: 'Moderate',
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage(
                              timed: timed,
                              category: 'Hard',
                            )));
              }

              // /**
              //    * Replace '/quizpage with the correct route to be navigated after category is chosen
              //    */
              // if (this.widget.title == 'Easy') {
              //   await prefs.setCategory('Easy');
              //   _navigate(context);
              // } else if (this.widget.title == 'Moderate') {
              //   await prefs.setCategory('Moderate');
              //   _navigate(context);

              //   //  Navigator.pushNamed(context, '/quizPage');
              // } else {
              //   await prefs.setCategory('Hard');
              //   _navigate(context);

              //   //Navigator.pushNamed(context, '/quizPage');
              // }
            },
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: this.widget.title == 'Easy'
                                ? cardEasyColor
                                : this.widget.title == 'Moderate'
                                    ? cardModerateColor
                                    : cardHardColor),
                      ),
                      _column()
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget _column() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                    image: this.widget.title == 'Easy'
                        ? AssetImage('assets/easy.png')
                        : this.widget.title == 'Moderate'
                            ? AssetImage('assets/moderate.png')
                            : AssetImage('assets/hard.png'))),
          ),
          Text(
            this.widget.title,
            style: categoryName,
          )
        ],
      ),
    );
  }
}
