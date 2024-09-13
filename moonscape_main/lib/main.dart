import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moonscape_main/screens/dashboard.dart';
import 'package:moonscape_main/screens/login_page.dart';
import 'package:moonscape_main/screens/select_mode.dart';
import 'package:moonscape_main/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ThemeData customTheme = ThemeData(
  scaffoldBackgroundColor:
      Colors.white, // Sets the background color for Scaffold
  primaryColor: Colors.blue, // Customize the accent color
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // Customize text color
    bodyMedium: TextStyle(color: Colors.black), // Customize text color
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white, // AppBar background color
    elevation: 0, // Remove shadow
    iconTheme: const IconThemeData(color: Colors.black),
    toolbarTextStyle: const TextTheme(
      titleLarge:
          TextStyle(color: Colors.black, fontSize: 20), // Title color and size
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge:
          TextStyle(color: Colors.black, fontSize: 20), // Title color and size
    ).titleLarge,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue, // Button color
    textTheme: ButtonTextTheme.primary, // Button text color
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: Colors.blueAccent, // Accent color
      )
      .copyWith(secondary: Colors.blueAccent),
);

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('models');
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  // await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL']!,
  //   anonKey: dotenv.env['SUPABASE_KEY']!,
  // );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: customTheme,
      routes: {
        '/': (context) => const SplashScreen(),
        '/mode': (context) => const ModeSelectionScreen(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
