import 'package:flutter/material.dart';
import 'quiz_page.dart';

import 'leaderBoard.dart';
import 'quizPage.dart';

void main() {
  runApp(MyApp());
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: QuizPage(
        category: "Arithmetics",
        timed: true,
      ),
    );
  }
}


