import 'dart:async';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StopState();
}

class StopState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("HomeScreen");
  }
}