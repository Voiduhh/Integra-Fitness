import 'package:flutter/material.dart';
import 'tabs/today_tab.dart';
import 'tabs/meals_tab.dart';
import 'tabs/plans_tab.dart';
import 'tabs/community_tab.dart';
import 'tabs/profile_tab.dart';

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

const _slidePageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: SlidePageTransitionsBuilder(),
    TargetPlatform.iOS: SlidePageTransitionsBuilder(),
    TargetPlatform.macOS: SlidePageTransitionsBuilder(),
    TargetPlatform.windows: SlidePageTransitionsBuilder(),
    TargetPlatform.linux: SlidePageTransitionsBuilder(),
  },
);

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF58B99A);
    return MaterialApp(
      title: 'Integra Fitness',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.light,
            ).copyWith(
              surface: const Color(0xFFFFFFFF),
              outline: const Color(0xFF9DA69C),
              onSurface: const Color(0xFF252F28),
              inverseSurface: const Color(0xFF2D352F),
              inversePrimary: const Color(0xFF5BA388),
            ),
        scaffoldBackgroundColor: const Color(0xFFF2F5F1),
        fontFamily: 'Arial',
        useMaterial3: true,
        pageTransitionsTheme: _slidePageTransitionsTheme,
      ),
      darkTheme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.dark,
            ).copyWith(
              surface: const Color(0xFF17221D),
              outline: const Color(0xFF4D645D),
              onSurface: const Color(0xFFE4E8E4),
              inverseSurface: const Color(0xFFE4E8E4),
              inversePrimary: const Color(0xFF8AC8A2),
            ),
        scaffoldBackgroundColor: const Color(0xFF101714),
        fontFamily: 'Arial',
        useMaterial3: true,
        pageTransitionsTheme: _slidePageTransitionsTheme,
      ),
      home: FitnessHomePage(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: (isDark) => setState(
          () => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light,
        ),
      ),
    );
  }
}

class FitnessHomePage extends StatefulWidget {
  const FitnessHomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<FitnessHomePage> createState() => _FitnessHomePageState();
}

class _FitnessHomePageState extends State<FitnessHomePage> {
  int _selectedIndex = 0;
  static const _navItems = [
    (Icons.grid_view_rounded, 'Today'),
    (Icons.restaurant_menu_rounded, 'Meals'),
    (Icons.fitness_center_rounded, 'Plans'),
    (Icons.groups_rounded, 'Community'),
    (Icons.person_outline_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: IndexedStack(
        index: _selectedIndex,
        children: [
          const TodayTab(),
          const MealsTab(),
          const PlansTab(),
          const CommunityTab(),
          ProfileTab(onThemeChanged: widget.onThemeChanged),
        ],
      ),
    ),
    bottomNavigationBar: _BottomNavBar(
      selectedIndex: _selectedIndex,
      items: _navItems,
      onSelected: (index) => setState(() => _selectedIndex = index),
    ),
  );
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.selectedIndex,
    required this.items,
    required this.onSelected,
  });
  final int selectedIndex;
  final List<(IconData, String)> items;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < items.length; i++)
            _NavItem(
              icon: items[i].$1,
              label: items[i].$2,
              selected: selectedIndex == i,
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: label,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 23,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? colors.primary : colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
