import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _firstContainer(context, width, height),
        _mainBody(context, width, height),
        _container(height)
      ],
    ));
  }

  Widget _container(double height) {
    return Positioned(
        top: height * 0.153,
        child: Container(
          color: Colors.green,
          height: 5,
          width: 60,
        ));
  }

  Widget _firstContainer(BuildContext context, double width, double height) {
    return Positioned(
        top: 0,
        child: Container(
          width: width,
          height: height * 0.16,
          color: Colors.grey[200],
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                      text: TextSpan(
                          text: 'IQ Assessment: ',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                        TextSpan(
                            text: 'Cognitive',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ])),
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      color: Colors.redAccent[100],
                      onPressed: () {},
                      child: Text(
                        'End',
                        style: TextStyle(
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget _mainBody(BuildContext context, double width, double height) {
    return Positioned(
        top: height * 0.16,
        child: Container(
          width: width,
          height: height - (height * 0.16),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerRight,
                    child: _progressContainer()),
                SizedBox(height: 30),
                _question(),
                SizedBox(
                  height: 17,
                ),
                Expanded(child: _optionsContainer(width, height)),
                _button(),
              ],
            ),
          ),
        ));
  }

  Widget _progressContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              shape: BoxShape.circle),
          child: Center(child: Text('70')),
        ),
        Text(
          'Approximately 10 Questions Remaining',
          style: TextStyle(fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget _optionsContainer(double width, double height) {
    return Builder(builder: (BuildContext _context) {
      return Container(
        width: width,
        // height: (height - (height * 0.16)) * 0.3,
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (_context, index) {
              return CardOptions();
            }),
      );
    });
  }

  Widget _question() {
    return Builder(builder: (BuildContext _context) {
      return Text(
        'What is the best way to avoid being eaten by a shark ? ',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
      );
    });
  }

  Widget _button() {
    return Builder(builder: (BuildContext _context) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[700], borderRadius: BorderRadius.circular(10)),
          width: 200,
          height: 70,
          child: MaterialButton(
              // color: Colors.blue,
              child: Text(
                'Next Question',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {}),
        ),
      );
    });
  }
}

class CardOptions extends StatefulWidget {
  @override
  _CardOptionsState createState() => _CardOptionsState();
}

class _CardOptionsState extends State<CardOptions> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            setState(() {
              _selected = !_selected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selected ? Colors.green : Colors.white,
                border: Border.all(color: Colors.black26)),
            height: 75,
            width: width,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'Tuesday',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
