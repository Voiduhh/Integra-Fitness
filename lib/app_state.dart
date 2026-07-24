import 'package:flutter/foundation.dart';

/// Global app state used across the app.
///
/// `isDarkMode` is a shared state notifier so any widget can read and react
/// to theme changes without requiring props to be passed down manually.
final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(true);
