import 'package:flutter/foundation.dart';

/// Global app state used across the app.
///
/// `isDarkMode` is a shared state notifier so any widget can read and react
/// to theme changes without requiring props to be passed down manually.
final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(true);

/// Global selected tab index for root navigation.
final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

/// Chosen metrics the user wants to surface on the profile dashboard.
final ValueNotifier<List<String>> preferredMetrics =
    ValueNotifier<List<String>>(<String>['Steps', 'Water', 'Calories']);

/// Preferred unit for water tracking.
final ValueNotifier<String> waterUnit = ValueNotifier<String>('Liters');

/// Preferred unit for calories tracking.
final ValueNotifier<String> calorieUnit = ValueNotifier<String>('kcal');

// Global time greeting function.
String getTimeGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good morning';
  } else if (hour < 18) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
