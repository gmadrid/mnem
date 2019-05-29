import 'package:flutter/material.dart';
import 'input_screen.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Mnem",
        theme: _buildTheme(),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Mnem"),
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Color.fromRGBO(255, 0, 0, 1.0),
                child: Text("foo"),
              ),
              Container(
                color: Color.fromRGBO(0, 255, 0, 1.0),
                child: Text("bar"),
              ),
              Container(
                color: Color.fromRGBO(255, 255, 0, 1.0),
                child: Text("quux"),
              ),
              InputWidget(),
            ],
          ),
        ));
  }

  ThemeData _buildTheme() {
    return ThemeData.light();
  }
}
