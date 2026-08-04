import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_fitness_app/app_state.dart';
import 'package:flutter_fitness_app/main.dart';

void main() {
  setUp(() {
    isDarkMode.value = true;
    selectedTab.value = 0;
  });

  testWidgets('app starts on Today tab and displays main dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Good'), findsOneWidget);
    expect(find.textContaining('Alex'), findsOneWidget);
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

    selectedTab.value = 1;
    await tester.pumpAndSettle();

    expect(find.text('Today’s food tracking'), findsOneWidget);
    expect(find.text('Your daily balance'), findsNothing);

    selectedTab.value = 2;
    await tester.pumpAndSettle();

    expect(find.text('Current workout'), findsOneWidget);
    expect(find.text('Today’s food tracking'), findsNothing);

    selectedTab.value = 3;
    await tester.pumpAndSettle();

    expect(find.text('Find your people and keep showing up.'), findsOneWidget);
  });

  testWidgets('today page actions change the selected tab', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('View plan'));
    await tester.pumpAndSettle();

    expect(selectedTab.value, 2);
    expect(find.text('Current workout'), findsOneWidget);
  });

  testWidgets('plans tab shows workout builder and saved routines', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    selectedTab.value = 2;
    await tester.pumpAndSettle();

    expect(find.text('Current workout'), findsOneWidget);
    expect(find.text('Workout builder'), findsOneWidget);
    expect(find.text('Saved routines'), findsOneWidget);
  });

  testWidgets('profile preferences let users choose units', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    selectedTab.value = 4;
    await tester.pumpAndSettle();

    expect(find.text('Preferred units'), findsOneWidget);
    expect(find.text('Water'), findsWidgets);

    await tester.ensureVisible(find.text('Preferred units'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cups'));
    await tester.pumpAndSettle();

    expect(waterUnit.value, 'Cups');

    await tester.ensureVisible(find.text('Preferred units'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('cal'));
    await tester.pumpAndSettle();

    expect(calorieUnit.value, 'cal');
  });

  testWidgets('settings page opens from profile and theme toggle works', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    selectedTab.value = 4;
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
    expect(isDarkMode.value, isTrue);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    expect(find.text('Appearance'), findsOneWidget);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    expect(isDarkMode.value, isFalse);
  });
}
