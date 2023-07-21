import 'package:aplikasi_health_detector_rev1/Provider/auth/auth_provider.dart';
import 'package:aplikasi_health_detector_rev1/Provider/db/data_diagnosa_provider.dart';
import 'package:aplikasi_health_detector_rev1/Provider/db/data_history_provider.dart';
import 'package:aplikasi_health_detector_rev1/Provider/db/data_klinis_provider.dart';
import 'package:aplikasi_health_detector_rev1/Screens/auth/login.dart';
import 'package:aplikasi_health_detector_rev1/Screens/auth/register.dart';
import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/chart_screen.dart';
import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/dataKlinis.dart';
import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/hasil_diagnosa.dart';
import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/home.dart';
import 'package:aplikasi_health_detector_rev1/Screens/mainActivityScreen.dart';
import 'package:aplikasi_health_detector_rev1/Screens/splash_screen.dart';
import 'package:aplikasi_health_detector_rev1/Screens/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/bottomNavBar/bottom_nav_bar_provider.dart';
import 'Screens/bottomNavBar/diastolik_grafik.dart';
import 'Screens/bottomNavBar/get_test_value.dart';
import 'Screens/bottomNavBar/heart_rate_grafik.dart';
import 'Screens/bottomNavBar/history.dart';
import 'Screens/start_diagnose.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    User? user;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => DataKlinisProvider()),
        ChangeNotifierProvider(create: (context) => DataDiagnosaProvider()),
        ChangeNotifierProvider(create: (context) => DataHistoryProvider())
      ],
      child: MaterialApp(
        title: "Aplikasi Health Detector",
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          '/': (context) => const WelcomeScreen(),
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegisterScreen(),
          'history': (context) => const HistoryScreen(),
          'home': (context) => const HomeScreen(),
          // 'dataKlinis': (context) => const DataKlinisScreen(),
          'mainScreen': (context) => const MainActivityScreen(),
          'start_diagnose': (context) => const StartDiagnoseScreen(),
          'hasil_diagnose': (context) => const HasilDiagnosaScreens(),
          'splash_screen': (context) => const SplashScreen(),
          'chart': (context) => ChartPage(),
          'heart_rate': (context) => HeartRateGraph(),
          'get_data': (context) => RealtimeDataWidget(),
          'heart_rate_graph': (context) => HeartRateGraph(),
        },
      ),
    );
  }
}
