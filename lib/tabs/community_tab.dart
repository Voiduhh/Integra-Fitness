import 'package:flutter/material.dart';
import 'simple_tab_view.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab() : super(key: const ValueKey<String>('CommunityTab'));

  @override
  Widget build(BuildContext context) {
    return const SimpleTabView(
      icon: Icons.groups_rounded,
      title: 'Community',
      subtitle: 'Find your people and keep showing up.',
    );
  }
}
