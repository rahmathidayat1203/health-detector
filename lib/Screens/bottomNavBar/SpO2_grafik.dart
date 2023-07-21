import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/syastolik_grafik.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'diastolik_grafik.dart';

class Spo2Graf extends StatefulWidget {
  const Spo2Graf({super.key});

  @override
  _Spo2GrafState createState() => _Spo2GrafState();
}

class _Spo2GrafState extends State<Spo2Graf> {
  String? currentUserUid;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    String? uid = await getCurrentUserUid();
    setState(() {
      currentUserUid = uid;
    });
  }

  Future<String?> getCurrentUserUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPO 2 Graph',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Heart Rate Graph'),
        ),
        body: currentUserUid != null
            ? HeartRateChart(currentUserUid!) // Use the UID obtained
            : Center(child: CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => SystolicGraph())));
          },
          child: Icon(Icons.arrow_right_sharp),
        ),
      ),
    );
  }
}

class HeartRateChart extends StatelessWidget {
  final String uid;

  HeartRateChart(this.uid);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('dataKlinis')
          .where('uid', isEqualTo: uid) // Filter based on the user's UID
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final readings = snapshot.data!.docs;
          if (readings.isEmpty) {
            // Handle the case when no data is available for the user.
            return Center(child: Text('No heart rate data available.'));
          }

          // Assuming the 'heartrate' subcollection exists in each 'dataKlinis' document.
          List<HeartRateData> data =
              readings.map((doc) => HeartRateData.fromFirestore(doc)).toList();

          return SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              LineSeries<HeartRateData, DateTime>(
                dataSource: data,
                xValueMapper: (HeartRateData data, _) => data.time,
                yValueMapper: (HeartRateData data, _) => data.heartRate,
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class HeartRateData {
  final DateTime time;
  final int heartRate;

  HeartRateData(this.time, this.heartRate);

  // Factory constructor to convert Firestore document to HeartRateData object
  factory HeartRateData.fromFirestore(DocumentSnapshot doc) {
    Timestamp timestamp = doc['timestamp'];
    int heartRate = doc['spo2'];
    DateTime createdAtDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return HeartRateData(createdAtDate, heartRate);
  }
}
