import 'package:flutter/material.dart';

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
        ));
  }

  ThemeData _buildTheme() {
    return ThemeData.light();
  }
}
