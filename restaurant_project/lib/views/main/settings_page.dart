import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () {
                // Navigate to language settings
              },
            ),
            ListTile(
              leading: Icon(Icons.palette),
              title: Text('Theme'),
              onTap: () {
                // Navigate to theme selection
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                // Navigate to notification settings
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Privacy & Security'),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}
