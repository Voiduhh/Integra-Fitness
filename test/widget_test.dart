import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_fitness_app/app_state.dart';
import 'package:flutter_fitness_app/main.dart';

void main() {
  setUp(() {
    isDarkMode.value = true;
    selectedTab.value = 0;
  });

  testWidgets('fitness dashboard navigates between tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Good'), findsOneWidget);
    expect(find.textContaining('Alex'), findsOneWidget);
    expect(find.text('Your daily balance'), findsOneWidget);

    selectedTab.value = 1;
    await tester.pumpAndSettle();

    expect(find.text('Today’s food tracking'), findsOneWidget);
    expect(find.text('Your daily balance'), findsNothing);

    selectedTab.value = 4;
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsWidgets);
    expect(find.byIcon(Icons.settings_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Dark mode'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    expect(isDarkMode.value, isTrue);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Light mode'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
    expect(isDarkMode.value, isFalse);
  });
}
