import 'package:flutter/material.dart';
import 'profile_view.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab() : super(key: const ValueKey<String>('ProfileTab'));

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}
