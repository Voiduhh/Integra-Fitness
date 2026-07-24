import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayView extends StatelessWidget {
  const TodayView() : super(key: const ValueKey<String>('TodayView'));

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, MMMM d').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Good morning, Alex',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 23,
                  backgroundColor: Color(0xFFD8ECE5),
                  child: Text('A', style: _avatarStyle),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _ProgressCard(),
            const SizedBox(height: 28),
            const _SectionHeader(title: "Today's rhythm", action: 'See all'),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    label: 'Move',
                    value: '420',
                    unit: 'kcal',
                    icon: Icons.local_fire_department_rounded,
                    color: Color(0xFFF8E4C8),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _MetricCard(
                    label: 'Hydration',
                    value: '1.2',
                    unit: 'L',
                    icon: Icons.water_drop_rounded,
                    color: Color(0xFFDCECF2),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _MetricCard(
                    label: 'Mindful',
                    value: '12',
                    unit: 'min',
                    icon: Icons.spa_rounded,
                    color: Color(0xFFE7E4F3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const _SectionHeader(title: 'Up next', action: 'View plan'),
            const SizedBox(height: 12),
            const _WorkoutCard(),
            const SizedBox(height: 28),
            const _SectionHeader(title: 'Fuel your day', action: 'Log meal'),
            const SizedBox(height: 12),
            const _MealCard(),
          ]),
        ),
      ),
    ],
  );
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1B6B5B),
      borderRadius: BorderRadius.circular(22),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 86,
          height: 86,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: 0.72,
                  strokeWidth: 10,
                  color: const Color.fromARGB(255, 219, 238, 8),
                  backgroundColor: Colors.white24,
                ),
              ),
              const Text(
                '72%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your daily balance',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              SizedBox(height: 5),
              Text(
                'You are in a great flow.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 7),
              Text(
                '2 of 3 goals completed today',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white70,
          size: 16,
        ),
      ],
    ),
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });
  final String label, value, unit;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 10, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: color,
            child: Icon(icon, size: 16, color: colors.onSurface),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 3),
          RichText(
            text: TextSpan(
              style: TextStyle(color: colors.onSurface),
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: ' $unit', style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _FeatureIcon(
            icon: Icons.directions_run_rounded,
            background: const Color(0xFFC8DFD2),
            foreground: const Color(0xFF1B6B5B),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Strength & mobility',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '35 min  •  Full body',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.play_circle_fill_rounded, color: colors.primary, size: 32),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  const _MealCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          _FeatureIcon(
            icon: Icons.wb_sunny_rounded,
            background: const Color(0xFFF6E5C9),
            foreground: const Color(0xFFB77528),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Breakfast',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  'Greek yogurt bowl  •  340 kcal',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.add_circle_outline_rounded,
            color: colors.primary,
            size: 27,
          ),
        ],
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({
    required this.icon,
    required this.background,
    required this.foreground,
  });
  final IconData icon;
  final Color background, foreground;

  @override
  Widget build(BuildContext context) => Container(
    width: 54,
    height: 54,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Icon(icon, color: foreground, size: 28),
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.action});
  final String title, action;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: colors.onSurface,
          ),
        ),
        Text(
          action,
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

const _avatarStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w800,
  color: Color(0xFF1B6B5B),
);
