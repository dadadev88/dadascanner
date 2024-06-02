import 'package:dadascanner/providers/global_app_provider.dart';
import 'package:dadascanner/screens/screens.dart';
import 'package:dadascanner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dadascanner/providers/providers.dart';
import 'package:dadascanner/utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesUtil.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ScansProvider()),
      ChangeNotifierProvider(create: (_) => PreferencesProvider()),
      ChangeNotifierProvider(create: (_) => GlobalAppProvider())
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
      color: Colors.indigo,
      debugShowCheckedModeBanner: false,
      title: 'Scanner DADADev',
      initialRoute: ProductScreen.routerName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        MapScreen.routeName: (_) => const MapScreen(),
        ProductScreen.routerName: (_) => const ProductScreen(),
      },
      themeMode: preferences.themeMode,
    );
  }

  ThemeData _getTheme(bool isDarkMode, bool isUseMaterial3) {
    const AppBarTheme barTheme = AppBarTheme( color: AppColors.primary, titleTextStyle: TextStyle(color: Colors.white, fontSize: 20) );

    return isDarkMode
      ? ThemeData.dark(useMaterial3: isUseMaterial3)
        .copyWith(appBarTheme: barTheme)
      : ThemeData.light(useMaterial3: isUseMaterial3)
        .copyWith(appBarTheme: barTheme);
  }
}
