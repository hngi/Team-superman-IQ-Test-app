import 'package:example/bottombar.dart';
import 'package:example/categories/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          label: Text('Back to Home')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 200),
        child: Container(
          // color: Colors.red,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: Column(
              children: <Widget>[
                Text(
                  username ?? 'Player',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Text(
                    'You got ${mark.toString() ?? 0.toString()} questions correctly',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

// SingleChildScrollView(
//             child: Align(
//               alignment: Alignment.center,
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     username ?? '',
//                     style: GoogleFonts.aBeeZee(
//                         fontSize: 50, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                    'You got ${mark.toString() ?? 0.toString()} questions correctly'
//                     '',
//                     style: GoogleFonts.aBeeZee(
//                         fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
