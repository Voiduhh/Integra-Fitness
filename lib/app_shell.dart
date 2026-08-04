import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_state.dart';
import 'app_theme.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  void initState() {
    super.initState();
    isDarkMode.addListener(_themeChanged);
  }

  @override
  void dispose() {
    isDarkMode.removeListener(_themeChanged);
    super.dispose();
  }

  void _themeChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integra Fitness',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: buildAppTheme(brightness: Brightness.light),
      darkTheme: buildAppTheme(brightness: Brightness.dark),
      home: const FitnessHomePage(),
    );
  }
}

class FitnessHomePage extends StatefulWidget {
  const FitnessHomePage({super.key});

  @override
  State<FitnessHomePage> createState() => _FitnessHomePageState();
}

class _FitnessHomePageState extends State<FitnessHomePage> {
  @override
  void initState() {
    super.initState();
    selectedTab.addListener(_tabChanged);
  }

  @override
  void dispose() {
    selectedTab.removeListener(_tabChanged);
    super.dispose();
  }

  void _tabChanged() => setState(() {});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: IndexedStack(
        index: selectedTab.value,
        children: [
          for (var i = 0; i < AppTabRouter.tabs.length; i++)
            AppTabRouter.buildScreenForIndex(i),
        ],
      ),
    ),
    bottomNavigationBar: _BottomNavBar(
      selectedIndex: selectedTab.value,
      items: AppTabRouter.tabs,
      onSelected: (index) => selectedTab.value = index,
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
  final List<AppTabInfo> items;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BottomAppBar(
      color: colors.surface,
      elevation: 0,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0)
                  Container(
                    width: 1,
                    height: 32,
                    color: colors.outlineVariant.withValues(alpha: 0.5),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                Expanded(
                  child: _NavItem(
                    icon: items[i].icon,
                    label: items[i].label,
                    selected: selectedIndex == i,
                    onTap: () => onSelected(i),
                  ),
                ),
              ],
            ],
          ),
        ),
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
      container: true,
      label: label,
      selected: selected,
      onTap: onTap,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: selected
                ? colors.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
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
