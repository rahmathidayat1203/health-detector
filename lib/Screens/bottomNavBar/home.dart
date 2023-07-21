import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth/auth_provider.dart';
import '../../Style/colors.dart';

import 'package:flutter_gif/flutter_gif.dart';

import 'chart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late FlutterGifController controller;

  get children => null;

  @override
  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = FirebaseAuth.instance.currentUser;
    String? displayName = user?.displayName;
    String? photoUrl = user?.photoURL;
    String? email = user?.email;

    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 90.0, left: 20.0),
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 80.0,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "SELAMAT DATANG " + displayName!.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  SizedBox(
                    height: 130.0,
                    child: Image.asset("assets/images/profil_dilakkkkk.jpg"),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(photoUrl!),
                          ),
                          title: Text(
                            "${displayName}".toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('Alamat Email : ${email}'),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        Text("Tanggal Mendaftar   : 03/12/23"),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: AppColors.red),
                  onPressed: () {
                    authProvider.SignOut();
                    Navigator.pushNamed(context, "login");
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
