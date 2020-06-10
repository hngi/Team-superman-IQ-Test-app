import 'package:example/bottombar.dart';
import 'package:example/categories/utilities.dart';
import 'package:flutter/material.dart';

class Entrance extends StatefulWidget {
  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  TextEditingController _textEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SharedPrefs prefs = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage('assets/HigherIQ.png'))),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              controller: _textEditingController,
                              validator: UsernameValidator.validate,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  // fillColor: Colors.white,
                                  // filled: true,
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.extended(
                        icon: Icon(Icons.exit_to_app),
                        backgroundColor: Colors.blue,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            await prefs.setname(_textEditingController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          }
                        },
                        label: Text('Continue')),
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class UsernameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Username cannot be empty";
    }
    if (value.length < 2) {
      return "Username is too short";
    }
    return null;
  }
}
