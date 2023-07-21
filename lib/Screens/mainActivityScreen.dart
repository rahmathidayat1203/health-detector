import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Provider/bottomNavBar/bottom_nav_bar_provider.dart';
import '../Style/colors.dart';
import 'bottomNavBar/chart_screen.dart';
import 'bottomNavBar/get_test_value.dart';
import 'bottomNavBar/hasil_diagnosa.dart';
import 'bottomNavBar/heart_rate_grafik.dart';
import 'bottomNavBar/history.dart';
import 'bottomNavBar/history_user.dart';
import 'bottomNavBar/home.dart';
import 'bottomNavBar/lihat_data_klinis.dart';

class MainActivityScreen extends StatefulWidget {
  const MainActivityScreen({Key? key}) : super(key: key);

  @override
  State<MainActivityScreen> createState() => _MainActivityScreenState();
}

class _MainActivityScreenState extends State<MainActivityScreen> {
  int curentIndex = 0;
  String userRole =
      ""; // Gantikan dengan variabel untuk menyimpan peran pengguna

  @override
  void initState() {
    super.initState();
    getUserRole(); // Panggil fungsi untuk mendapatkan peran pengguna dari Firebase Firestore saat inisialisasi state
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(builder: (context, nav, child) {
      List<BottomNavigationBarItem> items = _getBottomNavItems(userRole);
      List<Widget> pages = _getPages(userRole);

      return Scaffold(
        body: pages[nav.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 15.0,
          iconSize: 20,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.red,
          items: items,
          currentIndex: nav.currentIndex,
          onTap: (value) {
            setState(() {
              nav.changeIndex = value;
            });
          },
        ),
      );
    });
  }

  Future<void> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid; // Gantikan dengan ID pengguna yang sedang aktif
    print(userId);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final userData = snapshot.data();
      print("data fetch :${userData}");
      if (userData != null) {
        setState(() {
          userRole = userData['role'];
        });
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      print('Error getting user role: $e');
    }
  }

  List<BottomNavigationBarItem> _getBottomNavItems(String userRole) {
    print("data:${userRole.toString()}");
    if (userRole.toString() == "admin") {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.history), label: "History"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.database), label: "Data Klinis"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.eye), label: "Lihat Data Klinis"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartBar),
            label: "Lihat Grafik Pengguna"),
      ];
    } else {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety), label: "Diagnosa"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.history), label: "History"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartLine), label: "Grafik"),
      ];
    }
  }

  List<Widget> _getPages(String userRole) {
    if (userRole == "admin") {
      return const [
        HomeScreen(),
        HistoryScreen(),
        RealtimeDataWidget(),
        LihatDataKlinisScreen(),
        ChartPage()
      ];
    } else {
      return const [
        HomeScreen(),
        RealtimeDataWidget(),
        HistoryUser(),
        HeartRateGraph()
      ];
    }
  }
}
