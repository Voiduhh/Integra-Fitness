import 'package:flutter/material.dart';
import 'settings/settings_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView() : super(key: const ValueKey<String>('ProfileView'));

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 32),
      children: [
        Text(
          'YOUR SPACE',
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 11,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings_rounded, color: colors.onSurface),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFD8ECE5),
                child: Text('A', style: _avatarStyle),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alex Morgan',
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '12 day consistency streak',
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
            ],
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}

const _avatarStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w800,
  color: Color(0xFF1B6B5B),
);
