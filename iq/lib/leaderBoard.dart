import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categories/utilities.dart';
import 'core/quiz_page.dart';

class Leader extends StatefulWidget {
  @override
  _LeaderState createState() => _LeaderState();
}

class _LeaderState extends State<Leader> {
  SharedPrefs prefs = SharedPrefs();
  String username;
  int mark;

  void getName() async {
    String name = await prefs.getname();
    int _mark = await prefs.getmark();
    setState(() {
      username = name;
      mark = _mark;
    });
  }

  @override
  void initState() {
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HigherIQ',
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.dashboard)
      ),
      // backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:
                        DecorationImage(image: AssetImage("assets/easy.png"))),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                username ?? "Player",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                mark != null ? "${((mark / 20) * 100) ?? 0}/100" : 0.toString(),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  height: 50,
                  width: 300,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    color: Colors.blue,
                    child: Text(
                      'Play another',
                      style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onPressed: () async {
                      bool timed = await prefs.getIsTimed();
                      print(timed);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPage(
                                    timed: timed,
                                  )));
                    },
                  ))
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
