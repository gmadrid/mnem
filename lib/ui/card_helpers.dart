import 'package:flutter/material.dart';

const SPADE_UNICHAR = '\u2660';
const HEART_UNICHAR = '\u2665';
const DIAMOND_UNICHAR = '\u2666';
const CLUB_UNICHAR = '\u2663';

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
      suitSymbol = HEART_UNICHAR;
      break;
    case 'S':
      suitSymbol = SPADE_UNICHAR;
      break;
    case 'D':
      suitSymbol = DIAMOND_UNICHAR;
      break;
    case 'C':
      suitSymbol = CLUB_UNICHAR;
      break;
  }
  return suitSymbol;
}
