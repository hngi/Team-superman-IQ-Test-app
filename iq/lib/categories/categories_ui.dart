import 'package:flutter/material.dart';

import 'utils.dart';

class ButtonImplementation extends StatefulWidget {
  final SharedPrefs sharedPrefs;
  ButtonImplementation(this.sharedPrefs);
  @override
  _ButtonImplementationState createState() => _ButtonImplementationState();
}

class _ButtonImplementationState extends State<ButtonImplementation> {
  SharedPrefs prefs;
  bool isTimed = false;
  var key = "nil";

  @override
  void initState() {
    prefs = widget.sharedPrefs;
    super.initState();
  }

  checkIsTimed(bool value) {
    value ? prefs.setIsTimed(true) : prefs.setIsTimed(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MaterialButton(onPressed: () {
            prefs.setCategory('Easy');
            //   key = "Easy";
          }),
          MaterialButton(onPressed: () {
            prefs.setCategory('Moderate');
            //  key = "Moderate";
          }),
          MaterialButton(onPressed: () {
            prefs.setCategory('Hard');
            //key = "Hard";
          }),
          Switch(
            onChanged: (value) {
              setState(() {
                isTimed = value;

                checkIsTimed(isTimed);
              });
            },
            value: isTimed,
          ),
          MaterialButton(onPressed: () {

            /**
             * Commented code is to check whether category is chosen before Start button is clicked
             */
            //    prefs.setCategory(key);
            // (key != "nil")
            //     ? Navigator.pushNamed(context, '/gamePage')
            //     : print('choose a category');
            Navigator.pushNamed(context, '/gamePage');
          }),
        ],
      ),
    );
  }
}
