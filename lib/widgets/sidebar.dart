import 'package:dadascanner/providers/preferences_provider.dart';
import 'package:dadascanner/screens/screens.dart';
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
            ListTile(
              trailing: const Icon(Icons.logout_rounded),
              title: const Text('Close session'),
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => false,
              ),
            ),
            SwitchListTile.adaptive(
              title: const Text('Dark mode'),
              subtitle: const Text('Change the app theme'),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  ThemeMode mode = value ? ThemeMode.dark : ThemeMode.light;
                  preferences.setThemeMode(mode);
                });
              },
            ),
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
    setState(() => preferences.setMaterial3Enable(value));
  }
}
