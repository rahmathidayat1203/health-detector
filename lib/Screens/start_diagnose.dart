import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class StartDiagnoseScreen extends StatefulWidget {
  const StartDiagnoseScreen({Key? key}) : super(key: key);

  @override
  State<StartDiagnoseScreen> createState() => _StartDiagnoseScreenState();
}

class _StartDiagnoseScreenState extends State<StartDiagnoseScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final firestoreReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/hasil_Diagnosa_dilakk.jpg",
                width: 250,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Silahkan Mulai Mendiagnosa",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                        ),
                        onPressed: () {
                          databaseReference.child('control_data').set({
                            'value': 1,
                          }).then((value) {
                            print('Data berhasil ditambahkan ke database!');
                          }).catchError((error) {
                            print('Terjadi error: $error');
                          });
                        },
                        icon: Icon(
                          Icons.play_circle_fill,
                          color: Colors.red,
                        ),
                        label: Text(
                          "Mulai",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                        ),
                        onPressed: () async {
                          // Tambahkan logika saat tombol "Stop" ditekan
                          final snapshot = await databaseReference
                              .child('data_diagnosa')
                              .get();
                          if (snapshot.exists) {
                            print(snapshot.value);
                          } else {
                            print('No data available.');
                          }
                        },
                        icon: Icon(
                          Icons.stop_circle,
                          color: Colors.red,
                        ),
                        label: Text(
                          "Stop",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
