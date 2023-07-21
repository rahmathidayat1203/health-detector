import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<UserData> _chartData = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirestore();
  }

  Future<void> _fetchDataFromFirestore() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('dataKlinis').get();

    final List<UserData> data = snapshot.docs.map((doc) {
      final Timestamp timestamp = doc['timestamp'] as Timestamp;
      final DateTime createdAtDate = timestamp.toDate();
      final String month = DateFormat('MMMM').format(createdAtDate);
      final String username = doc['nama'] as String;
      return UserData(month, username);
    }).toList();

    setState(() {
      _chartData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Chart'),
      ),
      body: Center(
        child: _chartData.isNotEmpty
            ? SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  interval: 1, // Set interval to 1
                ),
                series: <ChartSeries>[
                  BarSeries<UserData, String>(
                    dataSource: _chartData,
                    xValueMapper: (UserData data, _) => data.month,
                    yValueMapper: (UserData data, _) => _chartData.indexOf(
                        data), // Using index as a numeric value for y-axis
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

class UserData {
  final String month;
  final String username;

  UserData(this.month, this.username);
}
