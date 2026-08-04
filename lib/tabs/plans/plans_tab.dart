import 'package:flutter/material.dart';

class PlansTab extends StatefulWidget {
  const PlansTab() : super(key: const ValueKey<String>('PlansTab'));

  @override
  State<PlansTab> createState() => _PlansTabState();
}

class _PlansTabState extends State<PlansTab> {
  final int _selectedWorkoutIndex = 0;
  final int _previewWorkoutIndex = 0;

  final List<_WorkoutDay> _workoutDays = const [
    _WorkoutDay(
      day: 'Monday',
      title: 'Upper Body Power',
      time: '35 min',
      focus: 'Push + pull',
      exercises: [
        _Exercise(name: 'Bench press', sets: '3 sets', reps: '8-10 reps'),
        _Exercise(name: 'Bent-over rows', sets: '3 sets', reps: '10 reps'),
        _Exercise(name: 'Shoulder press', sets: '2 sets', reps: '12 reps'),
      ],
    ),
    _WorkoutDay(
      day: 'Tuesday',
      title: 'Lower Body Strength',
      time: '40 min',
      focus: 'Legs + glutes',
      exercises: [
        _Exercise(name: 'Back squats', sets: '4 sets', reps: '8 reps'),
        _Exercise(name: 'Romanian deadlifts', sets: '3 sets', reps: '10 reps'),
        _Exercise(name: 'Lunges', sets: '3 sets', reps: '12 reps each'),
      ],
    ),
    _WorkoutDay(
      day: 'Wednesday',
      title: 'Recovery Flow',
      time: '20 min',
      focus: 'Mobility',
      exercises: [
        _Exercise(name: 'Hip mobility', sets: '2 rounds', reps: '10 breaths'),
        _Exercise(name: 'Hamstring stretch', sets: '2 rounds', reps: '30 sec'),
        _Exercise(name: 'Breathing reset', sets: '1 set', reps: '5 mins'),
      ],
    ),
    _WorkoutDay(
      day: 'Thursday',
      title: 'Core & Conditioning',
      time: '25 min',
      focus: 'Abs + cardio',
      exercises: [
        _Exercise(name: 'Plank', sets: '3 sets', reps: '45 sec'),
        _Exercise(name: 'Mountain climbers', sets: '3 sets', reps: '20 reps'),
        _Exercise(name: 'Jump rope', sets: '3 rounds', reps: '1 min'),
      ],
    ),
    _WorkoutDay(
      day: 'Friday',
      title: 'Full Body Blast',
      time: '30 min',
      focus: 'Total body',
      exercises: [
        _Exercise(name: 'Deadlifts', sets: '3 sets', reps: '8 reps'),
        _Exercise(name: 'Push-ups', sets: '3 sets', reps: '12 reps'),
        _Exercise(name: 'Farmer carries', sets: '3 rounds', reps: '40 m'),
      ],
    ),
    _WorkoutDay(
      day: 'Saturday',
      title: 'Pilates Strength',
      time: '20 min',
      focus: 'Core + posture',
      exercises: [
        _Exercise(name: 'Pilates bridge', sets: '3 sets', reps: '12 reps'),
        _Exercise(name: 'Side leg lifts', sets: '2 sets', reps: '12 reps'),
        _Exercise(name: 'Bird dog', sets: '2 sets', reps: '10 reps'),
      ],
    ),
    _WorkoutDay(
      day: 'Sunday',
      title: 'Active Recovery',
      time: '15 min',
      focus: 'Light movement',
      exercises: [
        _Exercise(name: 'Walk', sets: '1 walk', reps: '20 mins'),
        _Exercise(name: 'Gentle stretching', sets: '2 rounds', reps: '10 mins'),
      ],
    ),
  ];

  final List<_Routine> _routines = const [
    _Routine(
      name: 'Full Body Blast',
      duration: '45 min',
      equipment: 'Dumbbells',
    ),
    _Routine(name: 'Core Circuit', duration: '20 min', equipment: 'Mat'),
    _Routine(name: 'Home Mobility', duration: '15 min', equipment: 'None'),
  ];

  final List<String> _equipment = const [
    'Dumbbells',
    'Resistance bands',
    'Bench',
    'Pull-up bar',
    'Yoga mat',
  ];

  bool _isTodayDay(int index) {
    final today = DateTime.now().weekday;
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return _workoutDays[index].day == days[today - 1];
  }

  late final ScrollController _chipScrollController = ScrollController();
  double? _dragStartX;

  void _handleChipSwipe(DragUpdateDetails details) {
    if (_dragStartX == null) {
      _dragStartX = details.globalPosition.dx;
      return;
    }

    final delta = details.globalPosition.dx - _dragStartX!;
    if (delta.abs() > 24) {
      if (delta > 0) {
        _chipScrollController.animateTo(
          (_chipScrollController.offset - 120).clamp(
            0.0,
            _chipScrollController.position.maxScrollExtent,
          ),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
        );
      } else {
        _chipScrollController.animateTo(
          (_chipScrollController.offset + 120).clamp(
            0.0,
            _chipScrollController.position.maxScrollExtent,
          ),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
        );
      }
      _dragStartX = null;
    }
  }

  void _handleChipSwipeEnd(DragEndDetails details) {
    _dragStartX = null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final currentWorkout = _workoutDays[_previewWorkoutIndex];

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plans',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Build momentum with a plan that fits your day.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              _SectionCard(
                title: 'Current workout',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.swipe_rounded,
                          size: 16,
                          color: colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Swipe the day row to reveal more days',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onHorizontalDragUpdate: _handleChipSwipe,
                      onHorizontalDragEnd: _handleChipSwipeEnd,
                      child: SingleChildScrollView(
                        controller: _chipScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(_workoutDays.length, (index) {
                            final day = _workoutDays[index];
                            final isCurrent = index == _selectedWorkoutIndex;
                            final isToday = _isTodayDay(index);
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(day.day),
                                selected: isCurrent,
                                selectedColor: colors.primaryContainer,
                                labelStyle: TextStyle(
                                  color: isCurrent
                                      ? colors.onPrimaryContainer
                                      : colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w700,
                                ),
                                avatar: isToday && !isCurrent
                                    ? Icon(
                                        Icons.today_rounded,
                                        size: 16,
                                        color: colors.primary,
                                      )
                                    : null,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentWorkout.day,
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                currentWorkout.title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colors.secondaryContainer,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            currentWorkout.time,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: colors.onSecondaryContainer,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentWorkout.focus,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...currentWorkout.exercises.map((exercise) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colors.outlineVariant),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${exercise.sets} • ${exercise.reps}',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: colors.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.fitness_center_rounded,
                              color: colors.primary,
                              size: 18,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Workout builder',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose from the equipment you have at home.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _equipment.map((item) {
                        return FilterChip(
                          label: Text(item),
                          selected: item == 'Dumbbells' || item == 'Yoga mat',
                          onSelected: (_) {},
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        label: const Text('Create a routine'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Saved routines',
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('View all'),
                ),
                child: Column(
                  children: _routines.map((routine) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest.withValues(
                            alpha: 0.4,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    routine.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${routine.duration} • ${routine.equipment}',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: colors.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit_outlined),
                              tooltip: 'Edit routine',
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outline_rounded),
                              tooltip: 'Remove routine',
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child, this.trailing});

  final String title;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _WorkoutDay {
  const _WorkoutDay({
    required this.day,
    required this.title,
    required this.time,
    required this.focus,
    required this.exercises,
  });

  final String day;
  final String title;
  final String time;
  final String focus;
  final List<_Exercise> exercises;
}

class _Exercise {
  const _Exercise({required this.name, required this.sets, required this.reps});

  final String name;
  final String sets;
  final String reps;
}

class _Routine {
  const _Routine({
    required this.name,
    required this.duration,
    required this.equipment,
  });

  final String name;
  final String duration;
  final String equipment;
}
