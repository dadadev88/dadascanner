import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:dadascanner/screens/screens.dart';
import 'package:dadascanner/services/pokemons_service.dart';
import 'package:dadascanner/providers/providers.dart';
import 'package:dadascanner/utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesUtil.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ScansProvider()),
      ChangeNotifierProvider(create: (_) => PreferencesProvider()),
      ChangeNotifierProvider(create: (_) => GlobalAppProvider()),
      ChangeNotifierProvider(create: (_) => PokemonsService())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider preferences = Provider.of<PreferencesProvider>(context);
    bool isDarkMode = preferences.themeMode == ThemeMode.dark;
    bool isUseMaterial3 = preferences.themeStyle == 1;

    return MaterialApp(
      theme: _getTheme(isDarkMode, isUseMaterial3),
      debugShowCheckedModeBanner: false,
      title: 'Scanner DADADev',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        ScanHomeScreen.routeName: (_) => const ScanHomeScreen(),
        MapScreen.routeName: (_) => const MapScreen(),
        PokemonsScreen.routeName: (_) => const PokemonsScreen(),
        PokemonScreen.routeName: (_) => const PokemonScreen(),
        CapturePokemonScreen.routeName: (_) => const CapturePokemonScreen(),
      },
      themeMode: preferences.themeMode,
    );
  }

  ThemeData _getTheme(bool isDarkMode, bool isUseMaterial3) {
    AppBarTheme appBarTheme = const AppBarTheme(elevation: 0);
    TextTheme textTheme = GoogleFonts.ptSansTextTheme(
      Theme.of(context).textTheme,
    );

    return isDarkMode
        ? ThemeData.dark(useMaterial3: isUseMaterial3)
            .copyWith(appBarTheme: appBarTheme, textTheme: textTheme)
        : ThemeData.light(useMaterial3: isUseMaterial3)
            .copyWith(appBarTheme: appBarTheme, textTheme: textTheme);
    // .copyWith(appBarTheme: appBarTheme);
  }
}
