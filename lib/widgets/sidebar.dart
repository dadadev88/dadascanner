import 'package:dadascanner/providers/preferences_provider.dart';
import 'package:dadascanner/screens/login_screen.dart';
import 'package:dadascanner/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider preferences = Provider.of<PreferencesProvider>(context);
    final bool isDarkMode = PreferencesUtil.themeMode == ThemeMode.dark;

    return Drawer(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const Text( 'Preferences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ),
            ListTile(
              trailing: const Icon(Icons.home),
              title: const Text('Back to login'),
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
            ),
            const Divider(),
            SwitchListTile.adaptive(
              title: const Text('Dark mode'),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  ThemeMode mode = value ? ThemeMode.dark : ThemeMode.light;
                  preferences.setThemeMode(mode);
                });
              },
            ),
            const Divider(),
            const Text('Theme style'),
            RadioListTile<int>.adaptive(
              title: const Text('Material 3'),
              value: 1,
              groupValue: PreferencesUtil.themeStyle,
              onChanged: (value) => _changeThemeStyle(preferences, value!),
            ),
            RadioListTile<int>.adaptive(
              title: const Text('Material 2'),
              value: 2,
              groupValue: PreferencesUtil.themeStyle,
              onChanged: (value) => _changeThemeStyle(preferences, value!),
            )
          ],
        ),
      ),
    );
  }

  void _changeThemeStyle(PreferencesProvider preferences, int value) {
    setState(() {
      preferences.setMaterial3Enable(value);
    });
  }
}

/* TextButton.icon(
            onPressed: () {
              Provider.of<PreferencesProvider>(context, listen: false)
                  .setThemeMode(ThemeMode.dark);
            },
            icon: const Icon(Icons.dark_mode_outlined),
            label: const Text('Dark Mode'),
          ),
          const Divider(),
          TextButton.icon(
            onPressed: () {
              Provider.of<PreferencesProvider>(context, listen: false)
                  .setThemeMode(ThemeMode.light);
            },
            icon: const Icon(Icons.light_mode),
            label: const Text('Light Mode'),
          ),
          const Divider(),
          TextButton.icon(
            onPressed: () {
              Provider.of<PreferencesProvider>(context, listen: false)
                  .setMaterial3Enable(true);
            },
            icon: const Icon(Icons.format_paint_sharp),
            label: const Text('Material 3'),
          ),
          const Divider(),
          TextButton.icon(
            onPressed: () {
              Provider.of<PreferencesProvider>(context, listen: false)
                  .setMaterial3Enable(false);
            },
            icon: const Icon(Icons.format_paint_outlined),
            label: const Text('Material 2'),
          ) */