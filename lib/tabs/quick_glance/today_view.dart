import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../app_state.dart';

class TodayView extends StatelessWidget {
  const TodayView() : super(key: const ValueKey<String>('TodayView'));

  @override
  Widget build(BuildContext context) {
    final darkMode = isDarkMode.value;
    return CustomScrollView(
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
                    backgroundColor: Color.fromARGB(255, 193, 214, 207),
                    child: Text('A', style: _avatarStyle),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _ProgressCard(),
              const SizedBox(height: 28),
              const _SectionHeader(
                title: "Today's rhythm",
                action: 'See all',
                tabValue: 3,
              ),
              const SizedBox(height: 12),
              _RhythmCarousel(darkMode: darkMode),
              const SizedBox(height: 28),
              const _SectionHeader(
                title: 'Up next',
                action: 'View plan',
                tabValue: 2,
              ),
              const SizedBox(height: 12),
              const _WorkoutCard(),
              const SizedBox(height: 28),
              const _SectionHeader(
                title: 'Fuel your day',
                action: 'Log meal',
                tabValue: 1,
              ),
              const SizedBox(height: 12),
              const _MealCard(),
            ]),
          ),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      selectedTab.value = 2;
    },
    borderRadius: BorderRadius.circular(22),
    child: Container(
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
    return InkWell(
      onTap: () {
        selectedTab.value = 3;
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
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
                  TextSpan(
                    text: ' $unit',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        selectedTab.value = 2;
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.outlineVariant),
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
            Icon(
              Icons.play_circle_fill_rounded,
              color: colors.primary,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  const _MealCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        selectedTab.value = 1;
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
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

class _RhythmCarousel extends StatefulWidget {
  const _RhythmCarousel({required this.darkMode});
  final bool darkMode;

  @override
  State<_RhythmCarousel> createState() => _RhythmCarouselState();
}

class _RhythmCarouselState extends State<_RhythmCarousel> {
  final ScrollController _scrollController = ScrollController();
  bool _showLeftFade = false;
  bool _showRightFade = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateFadeVisibility);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateFadeVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFadeVisibility() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    final leftVisible = current > 8;
    final rightVisible = current < maxScroll - 8;

    if (leftVisible != _showLeftFade || rightVisible != _showRightFade) {
      setState(() {
        _showLeftFade = leftVisible;
        _showRightFade = rightVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _MetricCard(
        label: 'Move',
        value: '420',
        unit: 'kcal',
        icon: Icons.local_fire_department_rounded,
        color: widget.darkMode
            ? const Color.fromARGB(255, 206, 148, 68)
            : const Color(0xFFF8E4C8),
      ),
      _MetricCard(
        label: 'Hydration',
        value: '1.2',
        unit: 'L',
        icon: Icons.water_drop_rounded,
        color: widget.darkMode
            ? const Color.fromARGB(255, 59, 154, 188)
            : const Color(0xFFDCECF2),
      ),
      _MetricCard(
        label: 'Daily Intake',
        value: '1.2',
        unit: 'L',
        icon: Icons.dining_rounded,
        color: widget.darkMode
            ? const Color.fromARGB(255, 63, 188, 59)
            : const Color.fromARGB(255, 208, 236, 209),
      ),
      _MetricCard(
        label: 'Mindful',
        value: '12',
        unit: 'min',
        icon: Icons.spa_rounded,
        color: widget.darkMode
            ? const Color.fromARGB(255, 164, 101, 180)
            : const Color(0xFFE7E4F3),
      ),
    ];

    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (context, _) => const SizedBox(width: 12),
              itemCount: metrics.length,
              itemBuilder: (context, index) =>
                  SizedBox(width: 150, child: metrics[index]),
            ),
          ),
          if (_showLeftFade)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.0, 0.4, 1.0],
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.7),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          if (_showRightFade)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: const [0.0, 0.4, 1.0],
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.7),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.action,
    required this.tabValue,
  });
  final String title, action;
  final int tabValue; // Index of the Food/Meals tab

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
        SizedBox(
          height: 30,
          width: 70,
          child: TextButton(
            onPressed: () {
              selectedTab.value = tabValue;
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              action,
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
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
