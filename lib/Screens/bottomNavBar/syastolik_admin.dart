// import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/syastolik_grafik.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import 'diastolik_grafik.dart';
// import 'guladarah_grafik.dart';

// class SuhuTubuhGrafAdmin extends StatefulWidget {
//   const SuhuTubuhGrafAdmin({super.key});

//   @override
//   _SuhuTubuhGrafAdminState createState() => _SuhuTubuhGrafAdminState();
// }

// class _SuhuTubuhGrafAdminState extends State<SuhuTubuhGrafAdmin> {
//   String? currentUserUid;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   Future<void> getCurrentUser() async {
//     String? uid = await getCurrentUserUid();
//     setState(() {
//       currentUserUid = uid;
//     });
//   }

//   Future<String?> getCurrentUserUid() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user = auth.currentUser;

//     if (user != null) {
//       return user.uid;
//     } else {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Suhu Tubuh Graph',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Suhu Tubuh Graph'),
//         ),
//         body: currentUserUid != null
//             ? HeartRateChart(currentUserUid!) // Use the UID obtained
//             : Center(child: CircularProgressIndicator()),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: ((context) => GulaDarahGraf())));
//           },
//           child: Icon(Icons.arrow_right_sharp),
//         ),
//       ),
//     );
//   }
// }

// class HeartRateChart extends StatelessWidget {
//   final String uid;

//   HeartRateChart(this.uid);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('dataKlinis')
//           .where('uid', isEqualTo: uid) // Filter based on the user's UID
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasData) {
//           final readings = snapshot.data!.docs;
//           if (readings.isEmpty) {
//             // Handle the case when no data is available for the user.
//             return Center(child: Text('No heart rate data available.'));
//           }

//           // Assuming the 'heartrate' subcollection exists in each 'dataKlinis' document.
//           List<HeartRateData> data =
//               readings.map((doc) => HeartRateData.fromFirestore(doc)).toList();

//           return SfCartesianChart(
//             primaryXAxis: DateTimeAxis(),
//             series: <ChartSeries>[
//               LineSeries<HeartRateData, DateTime>(
//                 dataSource: data,
//                 xValueMapper: (HeartRateData data, _) => data.time,
//                 yValueMapper: (HeartRateData data, _) => data.heartRate,
//               ),
//             ],
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

// class HeartRateData {
//   final DateTime time;
//   final int heartRate;

//   HeartRateData(this.time, this.heartRate);

//   // Factory constructor to convert Firestore document to HeartRateData object
//   factory HeartRateData.fromFirestore(DocumentSnapshot doc) {
//     Timestamp timestamp = doc['timestamp'];
//     int heartRate = doc['suhu_tubuh'];
//     DateTime createdAtDate =
//         DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
//     return HeartRateData(createdAtDate, heartRate);
//   }
// }
import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/hear_rate_admin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'diastolik_grafik.dart';

class SystolikGrafAdmin extends StatefulWidget {
  final String uid; // Add the uid as a parameter in the constructor
  SystolikGrafAdmin({required this.uid, Key? key}) : super(key: key);

  @override
  _SystolikGrafAdminState createState() => _SystolikGrafAdminState();
}

class _SystolikGrafAdminState extends State<SystolikGrafAdmin> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Graph'),
      ),
      body: currentUserUid != null
          ? HeartRateChart(uid: widget.uid) // Use the passed uid
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HeartRateGraphAdmin(
                uid: widget.uid,
              ),
            ),
          );
        },
        child: Icon(Icons.arrow_right_sharp),
      ),
    );
  }
}

class HeartRateChart extends StatelessWidget {
  final String uid;

  HeartRateChart({required this.uid}); // Receive the uid as a parameter

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('dataKlinis')
          .where('uid', isEqualTo: uid) // Filter based on the passed uid
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final readings = snapshot.data!.docs;
          if (readings.isEmpty) {
            return Center(child: Text('No heart rate data available.'));
          }

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

  factory HeartRateData.fromFirestore(DocumentSnapshot doc) {
    Timestamp timestamp = doc['timestamp'];
    int heartRate = doc['sys'];
    DateTime createdAtDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return HeartRateData(createdAtDate, heartRate);
  }
}
