import 'package:flutter/material.dart';

class SlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const SlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOut));

    return SlideTransition(position: animation.drive(tween), child: child);
  }
}

const slidePageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: SlidePageTransitionsBuilder(),
    TargetPlatform.iOS: SlidePageTransitionsBuilder(),
    TargetPlatform.macOS: SlidePageTransitionsBuilder(),
    TargetPlatform.windows: SlidePageTransitionsBuilder(),
    TargetPlatform.linux: SlidePageTransitionsBuilder(),
  },
);

ThemeData buildAppTheme({required Brightness brightness}) {
  const seedColor = Color(0xFF58B99A);

  return ThemeData(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: brightness,
        ).copyWith(
          surface: brightness == Brightness.light
              ? const Color(0xFFFFFFFF)
              : const Color(0xFF17221D),
          outline: brightness == Brightness.light
              ? const Color(0xFF9DA69C)
              : const Color(0xFF4D645D),
          onSurface: brightness == Brightness.light
              ? const Color(0xFF252F28)
              : const Color(0xFFE4E8E4),
          inverseSurface: brightness == Brightness.light
              ? const Color(0xFF2D352F)
              : const Color(0xFFE4E8E4),
          inversePrimary: brightness == Brightness.light
              ? const Color(0xFF5BA388)
              : const Color(0xFF8AC8A2),
        ),
    scaffoldBackgroundColor: brightness == Brightness.light
        ? const Color(0xFFF2F5F1)
        : const Color(0xFF101714),
    fontFamily: 'Arial',
    useMaterial3: true,
    pageTransitionsTheme: slidePageTransitionsTheme,
  );
}
