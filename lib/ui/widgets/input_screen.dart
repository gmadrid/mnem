import 'package:flutter/material.dart';
import 'package:mnem/ui/widgets/keyboards/numeric.dart';

enum InputType {
  numeric,
  playing_card,
};

class InputState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(height: 1.0, color: Colors.black),
        NumericKeyboard(textStyle: Theme.of(context).textTheme.headline),
      ],)
    );
  }
}

class InputWidget extends StatefulWidget {

  @override
  State createState() => InputState();
}
