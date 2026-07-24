import 'package:flutter/material.dart';
import 'profile_view.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({required this.onThemeChanged})
    : super(key: const ValueKey<String>('ProfileTab'));

  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return ProfileView(onThemeChanged: onThemeChanged);
  }
}
