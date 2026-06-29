import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:test_demo/widgets/counter_widget.dart';

void main() {
  testWidgets("Counter increases when button is pressed", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: CounterWidget()));

    //
    // Check initial value
    //

    expect(find.text("0"), findsOneWidget);

    //
    // Tap button
    //

    await tester.tap(find.byKey(const Key("increment_button")));

    await tester.pump();

    //
    // Check updated value
    //

    expect(find.text("1"), findsOneWidget);
  });
}
