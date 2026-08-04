import 'package:flutter/material.dart';

import 'tabs/community/community_tab.dart';
import 'tabs/food/food_tab.dart';
import 'tabs/plans/plans_tab.dart';
import 'tabs/profile/profile_tab.dart';
import 'tabs/quick_glance/today_tab.dart';

enum AppTab { today, food, plans, community, profile }

class AppTabInfo {
  const AppTabInfo({
    required this.tab,
    required this.label,
    required this.icon,
  });

  final AppTab tab;
  final String label;
  final IconData icon;
}

class AppTabRouter {
  static const List<AppTabInfo> tabs = [
    AppTabInfo(
      tab: AppTab.today,
      label: 'Today',
      icon: Icons.grid_view_rounded,
    ),
    AppTabInfo(
      tab: AppTab.food,
      label: 'Food',
      icon: Icons.restaurant_menu_rounded,
    ),
    AppTabInfo(
      tab: AppTab.plans,
      label: 'Plans',
      icon: Icons.fitness_center_rounded,
    ),
    AppTabInfo(
      tab: AppTab.community,
      label: 'Community',
      icon: Icons.groups_rounded,
    ),
    AppTabInfo(
      tab: AppTab.profile,
      label: 'Profile',
      icon: Icons.person_outline_rounded,
    ),
  ];

  static AppTabInfo infoForIndex(int index) {
    if (index < 0 || index >= tabs.length) {
      return tabs.first;
    }
    return tabs[index];
  }

  static AppTab tabForIndex(int index) => infoForIndex(index).tab;

  static Widget buildScreenForIndex(int index) {
    switch (tabForIndex(index)) {
      case AppTab.today:
        return const TodayTab();
      case AppTab.food:
        return const MealsTab();
      case AppTab.plans:
        return const PlansTab();
      case AppTab.community:
        return const CommunityTab();
      case AppTab.profile:
        return const ProfileTab();
    }
  }
}
