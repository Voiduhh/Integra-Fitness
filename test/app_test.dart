import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fitness_app/main.dart';

void main() {
  testWidgets('app starts on Today tab and displays main dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Good morning, Alex'), findsOneWidget);
    expect(find.text('Your daily balance'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Plans'), findsOneWidget);
    expect(find.text('Community'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('bottom navigation switches between tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Food'));
    await tester.pumpAndSettle();

    expect(find.text('Plan, log, and enjoy your day.'), findsOneWidget);
    expect(find.text('Good morning, Alex'), findsNothing);

    await tester.tap(find.text('Plans'));
    await tester.pumpAndSettle();

    expect(find.text('Your next best workout is waiting.'), findsOneWidget);
    expect(find.text('Plan, log, and enjoy your day.'), findsNothing);

    await tester.tap(find.text('Community'));
    await tester.pumpAndSettle();

    expect(find.text('Find your people and keep showing up.'), findsOneWidget);
  });

  testWidgets('settings page opens from profile and theme toggle works', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsWidgets);
    expect(find.byIcon(Icons.settings_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Help & feedback'), findsOneWidget);

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    expect(find.text('Appearance'), findsOneWidget);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
  });
}
