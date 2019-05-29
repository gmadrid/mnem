import 'package:flutter/material.dart';
import 'package:mnem/ui/widgets/keyboards/playing_card.dart';

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
<<<<<<< Updated upstream
=======
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
              Container(
                color: Color.fromRGBO(255, 0, 255, 1.0),
                child: PlayingCardKeyboard(textStyle: TextStyle()),
              ),
            ],
          ),
>>>>>>> Stashed changes
        ));
  }

  ThemeData _buildTheme() {
    return ThemeData.light();
  }
}
