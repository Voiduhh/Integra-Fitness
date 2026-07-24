import 'package:flutter/material.dart';
import '../../../app_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkMode, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: colors.surface,
            foregroundColor: colors.onSurface,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              _SettingsSection(
                title: 'Preferences',
                children: [
                  _SettingsTile(
                    icon: darkMode
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    title: 'Appearance',
                    subtitle: darkMode ? 'Dark mode' : 'Light mode',
                    trailing: Switch(
                      value: darkMode,
                      onChanged: (value) => isDarkMode.value = value,
                    ),
                  ),
                  _SettingsTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    subtitle: 'Manage alerts and reminders',
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
              _SettingsSection(
                title: 'Account',
                children: [
                  _SettingsTile(
                    icon: Icons.person_rounded,
                    title: 'Profile details',
                    subtitle: 'Update your name and avatar',
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                  _SettingsTile(
                    icon: Icons.lock_rounded,
                    title: 'Privacy',
                    subtitle: 'Manage data and permissions',
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
              _SettingsSection(
                title: 'Support',
                children: [
                  _SettingsTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & feedback',
                    subtitle: 'Get support or send feedback',
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                  _SettingsTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About',
                    subtitle: 'App version and legal info',
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Column(
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      indent: 18,
                      endIndent: 18,
                      color: colors.outlineVariant,
                    ),
                  children[i],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: colors.primary),
      title: Text(
        title,
        style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: colors.onSurfaceVariant),
      ),
      trailing: trailing,
    );
  }
}
