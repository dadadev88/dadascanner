import 'package:dadascanner/screens/screens.dart';
import 'package:dadascanner/utils/colors.dart';
import 'package:flutter/material.dart';

class AppScreen {
  String routeName;
  String title;
  IconData icon;
  Color? iconColor;

  AppScreen(
    this.routeName,
    this.title,
    this.icon, {
    this.iconColor = Colors.white,
  });
}

class HomeScreen extends StatelessWidget {
  static String routeName = 'home';
  final List<AppScreen> screens = [
    AppScreen(LoginScreen.routeName, 'Sign in', Icons.login,
        iconColor: Colors.blue),
    AppScreen(
        ScanHomeScreen.routeName, 'Scanner', Icons.qr_code_scanner_rounded,
        iconColor: Colors.green),
    AppScreen(PokemonsScreen.routeName, 'Pokemons', Icons.pets,
        iconColor: Colors.red),
    AppScreen(CapturePokemonScreen.routeName, 'Capture pokemon', Icons.camera,
        iconColor: Colors.red),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text('Screens')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: screens.length,
              itemBuilder: _getScreenItem,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getScreenItem(BuildContext context, int i) {
    AppScreen screen = screens[i];
    ThemeData theme = Theme.of(context);

    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? Colors.black26
              : Colors.white,
          borderRadius: _getBorderRadius(i, screens.length),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                decoration: BoxDecoration(
                  color: screen.iconColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  screen.icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                screen.title,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ]),
            // Icon(scren.icon, size: 20),
            const Icon(Icons.arrow_forward_ios_rounded, size: 20),
          ],
        ),
      ),
      onTap: () => Navigator.popAndPushNamed(
        context,
        screen.routeName,
      ),
    );
  }

  BorderRadiusGeometry _getBorderRadius(int i, int length) {
    Radius radius10 = const Radius.circular(10);
    if (length == 1) {
      return BorderRadius.circular(10);
    }

    if (i == 0) {
      return BorderRadius.only(topLeft: radius10, topRight: radius10);
    }

    if (i == length - 1) {
      return BorderRadius.only(bottomLeft: radius10, bottomRight: radius10);
    }

    return BorderRadius.zero;
  }
}
