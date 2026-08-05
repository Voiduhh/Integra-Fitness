import 'package:flutter/material.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab() : super(key: const ValueKey<String>('CommunityTab'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeader('Find your people and keep showing up.'),
          const SizedBox(height: 16),

          // Groups Section
          _buildSectionHeader('Groups', Icons.groups_rounded, onSeeAll: () {}),
          _buildGroupList(),
          const SizedBox(height: 24),

          // Friends List Section
          _buildSectionHeader('Friends', Icons.people_outline, onSeeAll: () {}),
          _buildFriendsList(),
          const SizedBox(height: 24),

          // Local Fitness Activities Section
          _buildSectionHeader(
            'Local Fitness Activities',
            Icons.fitness_center,
            onSeeAll: () {},
          ),
          _buildFitnessActivitiesList(),
          const SizedBox(height: 24),

          // Suggested Items Section
          _buildSectionHeader(
            'Suggested for You',
            Icons.recommend_outlined,
            onSeeAll: () {},
          ),
          _buildSuggestedItemsList(),
        ],
      ),
    );
  }

  Widget _buildHeader(String subtitle) {
    return Text(
      subtitle,
      style: const TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon, {
    VoidCallback? onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (onSeeAll != null)
          TextButton(onPressed: onSeeAll, child: const Text('See All')),
      ],
    );
  }

  Widget _buildGroupList() {
    final groups = [
      'Morning Runners Club',
      'Yoga Enthusiasts',
      'Weekend Hikers',
    ];
    return Column(
      children: groups.map((group) {
        return Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.group)),
            title: Text(group),
            subtitle: const Text('Active discussions & events'),
            trailing: ElevatedButton(
              onPressed: () {},
              child: const Text('Join'),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFriendsList() {
    final friends = ['Alex Johnson', 'Sarah Smith', 'Michael Brown'];
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                const CircleAvatar(radius: 28, child: Icon(Icons.person)),
                const SizedBox(height: 4),
                Text(friends[index], style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFitnessActivitiesList() {
    final activities = [
      {'title': 'Sunset Yoga Class', 'location': 'Central Park • 6:00 PM'},
      {'title': '5K Community Run', 'location': 'Downtown Track • Sat 8:00 AM'},
    ];

    return Column(
      children: activities.map((activity) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.event, color: Colors.orange),
            title: Text(activity['title']!),
            subtitle: Text(activity['location']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuggestedItemsList() {
    final suggestions = [
      {
        'title': 'HIIT Workout Challenge',
        'subtitle': 'Based on your recent activity',
      },
      {'title': 'Hydration Tracking Group', 'subtitle': 'Popular near you'},
    ];

    return Column(
      children: suggestions.map((item) {
        return Card(
          color: Colors.blue.shade50,
          child: ListTile(
            leading: const Icon(Icons.lightbulb_outline, color: Colors.amber),
            title: Text(item['title']!),
            subtitle: Text(item['subtitle']!),
            trailing: const Icon(Icons.add),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}
