import 'dart:async';

import 'package:example/categories/utilities.dart';
import 'package:example/entrance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'bottombar.dart';

class SplashTest extends StatefulWidget {
  @override
  _SplashTestState createState() => _SplashTestState();
}

class _SplashTestState extends State<SplashTest> {

  String username;
  @override
  void initState() {
    super.initState();
    getName();
    Timer(Duration(seconds: 5), () {
      if(username!= null){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => Entrance()));
      }
      
    });
  }

  void getName() async{
    String name = await sharedPrefs.getname();
    setState(() {
      username = name;
    });
  }

  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _firstVector(height, width),
          _secondVector(height, width),
          _titleVector(height, width),
          _spinkit(height, width),
          _lightVector(height, width)
        ],
      ),
    );
  }

  Widget _spinkit(double height, double width) {
    return Positioned(
        top: height * 0.87,
        left: width * 0.45,
        child: SpinKitThreeBounce(
          color: Colors.blue,
          size: 25,
        ));
  }

  Widget _lightVector(double height, double width) {
    return Positioned(
      top: height * 0.26,
      left: width * 0.25,
      child: Container(
          width: width,
          height: height * 0.5,
          decoration: BoxDecoration(
              // color: Colors.red,
              image:
                  DecorationImage(image: AssetImage('assets/Vector3.png')))),
    );
  }

  Widget _titleVector(double height, double width) {
    return Positioned(
      top: height * 0.31,
      child: Container(
          width: width,
          height: height * 0.5,
          decoration: BoxDecoration(
              // color: Colors.red,
              image:
                  DecorationImage(image: AssetImage('assets/HigherIQ.png')))),
    );
  }

  Widget _secondVector(double height, double width) {
    return Positioned(
      top: height * 0.31,
      child: Container(
          width: width,
          height: height * 0.5,
          decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(image: AssetImage('assets/Vector.png')))),
    );
  }

  Widget _firstVector(double height, double width) {
    return Positioned(
      top: height * 0.12,
      child: Container(
          width: width,
          height: height * 0.5,
          decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(image: AssetImage('assets/Vector1.png')))),
    );
  }
}
