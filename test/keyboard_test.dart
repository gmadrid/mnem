import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mnem/ui/card_helpers.dart';
import 'package:mnem/ui/widgets/keyboards/numeric.dart';
import 'package:mnem/ui/widgets/keyboards/playing_card.dart';

import 'helpers.dart';

void main() {
  testWidgets('test playing card keyboard', (WidgetTester tester) async {
    var result = "";

    var widget = ltr(PlayingCardKeyboard(
      textStyle: TextStyle(),
      onPressed: (ch) {
        result += ch;
      },
    ));

    await tester.pumpWidget(widget);

    await tester.tap(find.text("A"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("3"));
    await tester.tap(find.text("4"));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("6"));
    await tester.tap(find.text("7"));
    await tester.tap(find.text("8"));
    await tester.tap(find.text("9"));
    await tester.tap(find.text("T"));
    await tester.tap(find.text("J"));
    await tester.tap(find.text("Q"));
    await tester.tap(find.text("K"));
    await tester.tap(find.text(SPADE_UNICHAR));
    await tester.tap(find.text(HEART_UNICHAR));
    await tester.tap(find.text(DIAMOND_UNICHAR));
    await tester.tap(find.text(CLUB_UNICHAR));

    expect(
        result,
        equals("A23456789TJQK" +
            SPADE_UNICHAR +
            HEART_UNICHAR +
            DIAMOND_UNICHAR +
            CLUB_UNICHAR));
  });

  testWidgets('test numeric keyboard', (WidgetTester tester) async {
    var result = "";

    var widget = ltr(NumericKeyboard(
      textStyle: TextStyle(),
      onPressed: (ch) {
        result += ch;
      },
    ));

    await tester.pumpWidget(widget);

    await tester.tap(find.text('0'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('5'));
    await tester.tap(find.text('6'));
    await tester.tap(find.text('7'));
    await tester.tap(find.text('8'));
    await tester.tap(find.text('9'));

    expect(result, equals("0123456789"));
  });
}
