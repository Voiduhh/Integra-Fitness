import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_fitness_app/main.dart';

void main() {
  testWidgets('fitness dashboard navigates between tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Good morning, Alex'), findsOneWidget);
    expect(find.text('Your daily balance'), findsOneWidget);

    await tester.tap(find.text('Meals'));
    await tester.pump();

    expect(find.text('Meals'), findsNWidgets(2));
    expect(find.text('Plan, log, and enjoy your day.'), findsOneWidget);
    expect(find.text('Good morning, Alex'), findsNothing);

    await tester.tap(find.text('Profile'));
    await tester.pump();

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Dark mode'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(find.text('Light mode'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });
}
