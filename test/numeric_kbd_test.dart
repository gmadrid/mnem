import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mnem/ui/widgets/keyboards/numeric.dart';

void main() {
  testWidgets('test numeric keyboard', (WidgetTester tester) async {
    var result = "";

    var widget = Directionality(
        textDirection: TextDirection.ltr,
        child: NumericKeyboard(
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
