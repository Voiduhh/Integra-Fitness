import 'package:flutter/material.dart';
import 'today_view.dart';

class TodayTab extends StatelessWidget {
  const TodayTab() : super(key: const ValueKey<String>('TodayTab'));

  @override
  Widget build(BuildContext context) {
    return const TodayView();
  }
}
