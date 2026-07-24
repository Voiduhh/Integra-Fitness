import 'package:flutter/material.dart';
import '../simple_tab_view.dart';

class MealsTab extends StatelessWidget {
  const MealsTab() : super(key: const ValueKey<String>('MealsTab'));

  @override
  Widget build(BuildContext context) {
    return const SimpleTabView(
      icon: Icons.restaurant_menu_rounded,
      title: 'Food',
      subtitle: 'Plan, log, and enjoy your day.',
    );
  }
}
