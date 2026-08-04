import 'package:flutter/material.dart';

class MealsTab extends StatefulWidget {
  const MealsTab() : super(key: const ValueKey<String>('MealsTab'));

  @override
  State<MealsTab> createState() => _MealsTabState();
}

class _MealsTabState extends State<MealsTab> {
  final Set<String> _loggedMeals = <String>{};
  int _waterAmount = 2;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final foodEntries = <_MealEntry>[
      const _MealEntry(
        label: 'Breakfast',
        detail: 'Greek yogurt bowl',
        macroSummary: 'P 24g • C 31g • F 12g',
        protein: 24,
        carbs: 31,
        fat: 12,
        icon: Icons.breakfast_dining_rounded,
      ),
      const _MealEntry(
        label: 'Lunch',
        detail: 'Salmon quinoa salad',
        macroSummary: 'P 36g • C 28g • F 18g',
        protein: 36,
        carbs: 28,
        fat: 18,
        icon: Icons.lunch_dining_rounded,
      ),
      const _MealEntry(
        label: 'Snack',
        detail: 'Apple and almonds',
        macroSummary: 'P 8g • C 22g • F 10g',
        protein: 8,
        carbs: 22,
        fat: 10,
        icon: Icons.emoji_food_beverage_rounded,
      ),
      const _MealEntry(
        label: 'Dinner',
        detail: 'Chicken stir-fry bowl',
        macroSummary: 'P 42g • C 35g • F 16g',
        protein: 42,
        carbs: 35,
        fat: 16,
        icon: Icons.dinner_dining_rounded,
      ),
    ];
    final totalProtein = foodEntries.fold<int>(
      0,
      (sum, entry) => sum + entry.protein,
    );
    final totalCarbs = foodEntries.fold<int>(
      0,
      (sum, entry) => sum + entry.carbs,
    );
    final totalFat = foodEntries.fold<int>(0, (sum, entry) => sum + entry.fat);
    final totalCalories = totalProtein * 4 + totalCarbs * 4 + totalFat * 9;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Food',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track meals, build a grocery list, and discover recipes.',
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 15),
              ),
              const SizedBox(height: 24),
              _FoodSection(
                title: 'Today’s food tracking',
                subtitle: 'Log meals and hydration for the day.',
                icon: Icons.restaurant_menu_rounded,
                items: const [],
                featured: true,
                onTap: null,
                customContent: _MealTrackingContent(
                  title: 'Today’s food tracking',
                  subtitle: 'Log meals and hydration for the day.',
                  colors: colors,
                  entries: foodEntries,
                  loggedMeals: _loggedMeals,
                  waterAmount: _waterAmount,
                  onMealTap: (label) {
                    setState(() {
                      if (_loggedMeals.contains(label)) {
                        _loggedMeals.remove(label);
                      } else {
                        _loggedMeals.add(label);
                      }
                    });
                  },
                  onWaterChanged: (value) {
                    setState(() {
                      _waterAmount = value.clamp(0, 12);
                    });
                  },
                  onScanTap: () {},
                  totalProtein: totalProtein,
                  totalCarbs: totalCarbs,
                  totalFat: totalFat,
                  totalCalories: totalCalories,
                ),
              ),
              const SizedBox(height: 12),
              _FoodSection(
                title: 'Shopping list',
                subtitle: 'Plan the ingredients you still need.',
                icon: Icons.shopping_bag_outlined,
                items: const [],
                featured: false,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _FoodSection(
                title: 'Recipes based on your foods',
                subtitle: 'Ideas built from what you already have.',
                icon: Icons.auto_awesome_outlined,
                items: const [],
                featured: false,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _FoodSection(
                title: 'Community recipes',
                subtitle: 'Try favorites shared by the community.',
                icon: Icons.groups_rounded,
                items: const [],
                featured: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MealTrackingContent extends StatelessWidget {
  const _MealTrackingContent({
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.entries,
    required this.loggedMeals,
    required this.waterAmount,
    required this.onMealTap,
    required this.onWaterChanged,
    required this.onScanTap,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalCalories,
  });

  final String title;
  final String subtitle;
  final ColorScheme colors;
  final List<_MealEntry> entries;
  final Set<String> loggedMeals;
  final int waterAmount;
  final ValueChanged<String> onMealTap;
  final ValueChanged<int> onWaterChanged;
  final VoidCallback onScanTap;
  final int totalProtein;
  final int totalCarbs;
  final int totalFat;
  final int totalCalories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...entries.map((entry) {
          final selected = loggedMeals.contains(entry.label);
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => onMealTap(entry.label),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? colors.primaryContainer.withValues(alpha: 0.45)
                      : colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected
                        ? colors.primary.withValues(alpha: 0.4)
                        : colors.outlineVariant,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selected
                            ? colors.primary.withValues(alpha: 0.16)
                            : colors.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        entry.icon,
                        color: selected
                            ? colors.primary
                            : colors.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.label,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            entry.detail,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.macroSummary,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onScanTap,
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: colors.primary,
                            size: 20,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: colors.primaryContainer,
                            minimumSize: const Size(34, 34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        IconButton(
                          onPressed: () => onMealTap(entry.label),
                          icon: Icon(
                            selected
                                ? Icons.check_circle_rounded
                                : Icons.add_circle_outline,
                            color: selected
                                ? colors.primary
                                : colors.onSurfaceVariant,
                            size: 22,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: colors.secondaryContainer,
                            minimumSize: const Size(34, 34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.water_drop_outlined, color: colors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Water intake',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colors.onSurface,
                          ),
                        ),
                        Text(
                          '$waterAmount cups today',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: waterAmount > 0
                        ? () => onWaterChanged(waterAmount - 1)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '$waterAmount',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),
                  IconButton(
                    onPressed: () => onWaterChanged(waterAmount + 1),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(height: 1, color: colors.outlineVariant),
              const SizedBox(height: 10),
              Text(
                'Daily total • $totalCalories kcal',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _MacroProgressCard(
                      label: 'Protein',
                      value: totalProtein,
                      goal: 160,
                      unit: 'g',
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MacroProgressCard(
                      label: 'Carbs',
                      value: totalCarbs,
                      goal: 220,
                      unit: 'g',
                      color: colors.tertiary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MacroProgressCard(
                      label: 'Fat',
                      value: totalFat,
                      goal: 70,
                      unit: 'g',
                      color: colors.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MacroProgressCard extends StatelessWidget {
  const _MacroProgressCard({
    required this.label,
    required this.value,
    required this.goal,
    required this.unit,
    required this.color,
  });

  final String label;
  final int value;
  final int goal;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = (value / goal).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: color)),
              Text(
                '$value$unit',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Goal $goal$unit',
            style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.9)),
          ),
        ],
      ),
    );
  }
}

class _MealEntry {
  const _MealEntry({
    required this.label,
    required this.detail,
    required this.macroSummary,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.icon,
  });

  final String label;
  final String detail;
  final String macroSummary;
  final int protein;
  final int carbs;
  final int fat;
  final IconData icon;
}

class _FoodSection extends StatelessWidget {
  const _FoodSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.items,
    required this.featured,
    required this.onTap,
    this.customContent,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> items;
  final bool featured;
  final VoidCallback? onTap;
  final Widget? customContent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final content =
        customContent ??
        (featured
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: colors.secondaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          icon,
                          color: colors.onSecondaryContainer,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: TextStyle(
                                color: colors.onSurfaceVariant,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 8, color: colors.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: colors.onSurfaceVariant,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      color: colors.onSecondaryContainer,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colors.onSurfaceVariant,
                  ),
                ],
              ));

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(featured ? 22 : 16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: content,
        ),
      ),
    );
  }
}
