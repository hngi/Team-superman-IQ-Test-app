import 'package:flutter/material.dart';


class Leader extends StatefulWidget {
  @override
  _LeaderState createState() => _LeaderState();
}

class _LeaderState extends State<Leader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7CBE82),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100,),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("images/award.png")
                      )
                  ),
                ),
                SizedBox(height: 30,),
                Text("Duduke Duduke", style: TextStyle(fontSize:  30, color: Colors.white),),
                SizedBox(height: 30,),
                Text("Scored: 50/100", style: TextStyle(fontSize:  24, color: Colors.white),),

                SizedBox(height: 100,),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(40)
                  ),
                  height: 50,
                  width: 300,
                  child: Center(child: Text("Play another", style: TextStyle(fontSize: 20),)),
                )
              ],
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
