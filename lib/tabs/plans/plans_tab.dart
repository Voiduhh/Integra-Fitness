import 'package:flutter/material.dart';
import '../simple_tab_view.dart';

class PlansTab extends StatelessWidget {
  const PlansTab() : super(key: const ValueKey<String>('PlansTab'));

  @override
  Widget build(BuildContext context) {
    return const SimpleTabView(
      icon: Icons.fitness_center_rounded,
      title: 'Plans',
      subtitle: 'Your next best workout is waiting.',
    );
  }
}
