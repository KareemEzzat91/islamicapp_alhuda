import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Account Settings Section
            SectionHeader(title: 'Account Settings'),
            SettingsOption(title: 'Profile', onTap: () => print('Profile')),
            SettingsOption(title: 'Privacy', onTap: () => print('Privacy')),
            SettingsOption(title: 'Security', onTap: () => print('Security')),

            SizedBox(height: 20),

            // App Settings Section
            SectionHeader(title: 'App Settings'),
            SettingsOption(title: 'Notifications', onTap: () => print('Notifications')),
            SettingsOption(title: 'Language', onTap: () => print('Language')),
            SettingsOption(title: 'About', onTap: () => print('About')),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingsOption({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
