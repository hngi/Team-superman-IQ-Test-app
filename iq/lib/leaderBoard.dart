import 'package:example/bottombar.dart';
import 'package:example/database/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'categories/utilities.dart';
import 'core/quiz_page.dart';
import 'dart:math';
import 'database/models.dart';
import 'state/theme.dart';
import 'state/themeNotifier.dart';

class Leader extends StatefulWidget {
  @override
  _LeaderState createState() => _LeaderState();
}

class _LeaderState extends State<Leader> {
  SharedPrefs prefs = SharedPrefs();
  String username;
  int mark;

  ScoreDatabase db = ScoreDatabase.db;

  List<Score> scores = new List();
  List<int> number = [];
  int highest;
  int lowest;
  var _darkTheme;
  bool empty = false;

  @override
  void initState() {
    _something();
    _button();
    super.initState();
  }

  void _button() {
    db.getAllClients().then((scores) => {
          if (scores.isEmpty)
            {
              setState(() {
                empty = true;
              })
            }
        });
  }

  void _something() {
    db.getAllClients().then((scores) => {
          for (var i = 0; i < scores.length; i++)
            {
              setState(() {
                print(scores[i].mark);
                number.add(scores[i].mark);
                if (number.isNotEmpty) {
                  highest = number.reduce(max);
                  if (number.length > 1) {
                    lowest = number.reduce(min);
                  }
                  print(highest);
                }
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              Scaffold.of(context).showSnackBar(SnackBar(
                // duration: Duration(seconds: 3),
                content: Text('Select Difficulty level'),
              ));
              // Navigator.push(context, CupertinoPageRoute(builder: (context) => MyHomePage()));
            },
            label: Text(empty == false ? 'Play another' : 'Play A Game')),
        appBar: AppBar(
            title: Text(
              'Scores',
              style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.dashboard)),
        // backgroundColor: Colors.white,
        body: FutureBuilder<List<Score>>(
            future: db.getAllClients(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text('Your scores will appear here'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      int mark = snapshot.data[index].mark;
                      int score = ((mark / 20) * 100).toInt();
                      return Dismissible(
                        background: slideRightBackground(),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            final bool res = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                        "Are you sure you want to delete this score?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          db.deleteNote(
                                              snapshot.data[index].id);
                                          setState(() {
                                            snapshot.data.removeAt(index);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                            return res;
                          } else {}
                        },
                        key: Key(index.toString()),
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            color: snapshot.data[index].mark == highest
                                ? _darkTheme
                                    ? Colors.green[800]
                                    : Colors.green[400]
                                : snapshot.data[index].mark == lowest
                                    ? _darkTheme ? Colors.red[800] : Colors.red
                                    : _darkTheme
                                        ? Colors.black54
                                        : Colors.white,
                            child: ListTile(
                                title: Text(
                                  snapshot.data[index].name,
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  snapshot.data[index].mark == highest
                                      ? 'Highest score'
                                      : snapshot.data[index].mark == lowest
                                          ? 'Lowest score'
                                          : '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      score.toString() + '%',
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Swipe to delete >>>',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
