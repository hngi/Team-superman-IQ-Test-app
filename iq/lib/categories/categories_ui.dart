
import 'package:flutter/material.dart';
import 'package:custom_radio_button/custom_radio_button.dart';
import 'package:custom_radio_button/radio_model.dart';
import 'package:flutter/scheduler.dart';

import 'utilities.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.indigo,
          body: Stack(
            children: <Widget>[_backButton(width, height, context), _card(width, height)],
          )),
    );
  }

  Widget _card(double width, double height) {
    return Positioned(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Container(
            width: width * 0.9,
            height: height * 0.75,
            // color: Colors.red,
            child: Card(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: <Widget>[
                    _text(),
                    SizedBox(height: 0),
                    Expanded(child: _test(context)),
                    // Expanded(child: _buttonContainers(width, height)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Timer',
                                style: TextStyle(
                                  color: Colors.indigo,
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                        Expanded(child: _nextButton(width, height, context))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton(double width, double height, context) {
    return Positioned(
        top: height * 0.07,
        left: width * 0.02,
        child: IconButton(
          onPressed: (){
          },
         icon: Icon(Icons.arrow_back,
          size: 30,
          color: Colors.transparent,)
        ));
  }

  Widget _nextButton(double width, double height, BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        width: width * 0.32,
        height: height * 0.1,
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Text(
              'Next',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.blue,
            onPressed: () async {
              if (category == null) {
                scaffoldKey.currentState.showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Please select a Category'),
                ));
              } else {
                print(category);
                Navigator.pushNamed(context, '');
              }
            }),
      ),
    );
  }


  Widget _test(BuildContext context) {
    List<RadioModel> priorityList = new List<RadioModel>();
    priorityList.add(new RadioModel(false, null, 'Easy', Colors.redAccent));
    priorityList
        .add(new RadioModel(false, null, 'Moderate', Colors.deepPurple));
    priorityList.add(new RadioModel(false, null, 'Hard', Colors.blueAccent));
    return Container(
      // width: 1000,
      child: CustomRadioGroupWidget(
        onChanged: (value) {
          print(value);
          prefs.setCategory(value);
          category = value;
        },
        isSquareRadioGroup: false,
        radioList: priorityList,
      ),
    );
  }

  // void getvalue(dynamic value) {
  //   prefs.setCategory(value);

  //   _selectedValue = value;
  // }

  Widget _text() {
    return Text(
      'Select a Category',
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.indigo),
    );
  }
}
