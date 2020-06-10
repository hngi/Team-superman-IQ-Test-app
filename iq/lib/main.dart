import 'package:flutter/material.dart';

import 'leaderBoard.dart';
import 'quizPage.dart';

void main() {
  runApp(Leader());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}


class _MyAppState extends State<MyApp> {
  
  void answerquestion() {
    setState(() {} );
    print ("answer chosen");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('flutter'),
        ),
        body: Column(
          children: <Widget>[
            Text('The question'),
            RaisedButton(
              child: Text('answer 1'),
              onPressed: answerquestion,
            ),
            RaisedButton(
              child: Text('answer 2'),
              onPressed: () {
                //..
                print ('answer 2 chosen');
              },
            ),
            RaisedButton(
              child: Text('answer 3'),
              onPressed: answerquestion,
            ),
          ],
        ),
      ),
    );
  }
}
