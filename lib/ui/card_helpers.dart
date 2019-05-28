import 'package:flutter/material.dart';

// Cards are identified by name.
//
// PLAYING_CARD ==> PIPS SUIT  // There is no space between PIPS and SUIT
// PIPS         ==> A|2-9|T|J|Q|K
// SUIT         ==> S|C|H|D

// Outputs a List of Widgets to display the card name with proper symbols and coloring.
List<Widget> cardTexts(String cardName) {
  var pips = cardName[0];
  var suit = cardName[1];

  return [
    Text(pips),
    Text(symbolForSuit(suit), style: TextStyle(color: suitColor(suit))),
  ];
}

// Outputs a Color that is suitable for displaying a playing card.
Color suitColor(String suit) =>
    suit == 'H' || suit == 'D' ? Color(0xffff0000) : Color(0xff000000);

String symbolForSuit(String suit) {
  var suitSymbol;
  switch (suit) {
    case 'H':
      suitSymbol = "\u2665";
      break;
    case 'S':
      suitSymbol = "\u2660";
      break;
    case 'D':
      suitSymbol = "\u2666";
      break;
    case 'C':
      suitSymbol = "\u2663";
      break;
  }
  return suitSymbol;
}
