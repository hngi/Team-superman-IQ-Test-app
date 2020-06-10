import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'state/theme.dart';
import 'state/themeNotifier.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _darkTheme = true;
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      backgroundColor: _darkTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.aBeeZee()),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              // color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Dark Mode',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20
                      )
                    ),
                    // DayNightSwitch(

                    //   value: _darkTheme,
                    //   onChanged: (val) {
                    //     setState(() {
                    //       _darkTheme = val;
                    //     });
                    //     onThemeChanged(val, themeNotifier);
                    //   },
                    // ),
                    Switch(
                      activeTrackColor: Colors.blue,
                      inactiveThumbColor: Colors.white,
                      // inactiveTrackColor: Colors.grey[300],
                      activeColor: Colors.blue,
                      value: _darkTheme,
                      onChanged: (val) {
                        setState(() {
                          _darkTheme = val;
                        });
                        onThemeChanged(val, themeNotifier);
                      },
                    )
                  ],
                ),
                
               
                SizedBox(height: 20),
                Text(
                  'LEGAL',
                  style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                      )
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Terms of Service',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20
                      )
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right,
                          // color:Colors.black
                          ),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Privacy Policy',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20
                      )
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right,
                          // color: Colors.black
                          ),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'App Licenses',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20
                      )
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        // color: Colors.black,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'CONTACT US',
                  style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        fontWeight: FontWeight.w800

                      )
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Rate Us',
                  style: GoogleFonts.aBeeZee(
                        fontSize: 20
                      )
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Help and Support',
                  style: GoogleFonts.aBeeZee(
                        fontSize: 20
                      )
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Share This App',
                  style: GoogleFonts.aBeeZee(
                        fontSize: 20
                      )
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
    );
  }
  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}