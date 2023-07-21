import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Provider/db/data_klinis_provider.dart';
import '../../model/dataKlinis.dart';

class RealtimeDataWidget extends StatefulWidget {
  const RealtimeDataWidget({Key? key}) : super(key: key);

  @override
  _RealtimeDataWidgetState createState() => _RealtimeDataWidgetState();
}

class _RealtimeDataWidgetState extends State<RealtimeDataWidget> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("sensorData");
  String responseData = '';
  double? responseDataGulaDarah;

  String heartRate = '';
  String diastolic = '';
  String glucose = '';
  String spo2 = '';
  String ir = '';
  String red = '';
  String bodyTemperature = '';
  String systolic = '';

  // Create controllers to retain the input values
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController indexMasaTubuhController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  // Add a list to store the gender options for the dropdown
  List<String> genderOptions = ['Perempuan', 'Laki-laki'];
  int selectedGender = 0; // 0 for Perempuan, 1 for Laki-laki

  @override
  void initState() {
    super.initState();

    // Initialize Firebase if not already initialized
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp();
    }

    // Set up listeners to update data in real-time
    _databaseReference.child('hr').onValue.listen((event) {
      setState(() {
        heartRate = event.snapshot.value.toString();
      });
    });
    _databaseReference.child('ir').onValue.listen((event) {
      setState(() {
        ir = event.snapshot.value.toString();
      });
    });
    _databaseReference.child('red').onValue.listen((event) {
      setState(() {
        red = event.snapshot.value.toString();
      });
    });
    _databaseReference.child('gula_darah').onValue.listen((event) {
      setState(() {
        glucose = event.snapshot.value.toString();
      });
    });

    _databaseReference.child('dia').onValue.listen((event) {
      setState(() {
        diastolic = event.snapshot.value.toString();
      });
    });

    _databaseReference.child('spo2').onValue.listen((event) {
      setState(() {
        spo2 = event.snapshot.value.toString();
      });
    });

    _databaseReference.child('suhu_tubuh').onValue.listen((event) {
      setState(() {
        bodyTemperature = event.snapshot.value.toString();
      });
    });

    _databaseReference.child('sys').onValue.listen((event) {
      setState(() {
        systolic = event.snapshot.value.toString();
      });
    });

    // Get the current user from FirebaseAuth
    user = auth.currentUser;
  }

  Future<void> postDataKadarGula(
      String hr, String ir, String red, String spo2) async {
    final String apiUrl = 'http://warda.pythonanywhere.com/gula_darah';

    Map<String, dynamic> data = {
      'HR': int.tryParse(hr),
      'IR': int.tryParse(ir),
      'SPO2': int.tryParse(spo2),
      'RED': int.tryParse(red),
    };

    print(data);

    try {
      // Encode the JSON data
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        // Request was successful, handle the response data
        Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          this.responseDataGulaDarah = responseData[
              'message']; // Assuming the API response has a field called 'message'
        });
        print('Response: ${response.body}');
      } else {
        // Request failed with an error status code, handle the error
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      // Error occurred during the HTTP request, handle the exception
      print('Error: $e');
    }
  }

  Future<void> postDataDeteksi(
    String hr,
    String dia,
    String glucose,
    String spo2,
    String temp,
    String systolic,
  ) async {
    final String apiUrl =
        'http://warda.pythonanywhere.com/proses_svm'; // Replace with your API URL

    // Your data to be sent (assuming it's a JSON object)
    Map<String, dynamic> data = {
      'HeartRate': int.tryParse(hr),
      'Diastole': double.tryParse(dia),
      'BloodSugar': double.tryParse(glucose),
      'Spo2': int.tryParse(spo2),
      'Systole': double.tryParse(systolic),
      'Temperature': double.tryParse(temp),
      'Gender': selectedGender, // Use the selected gender value
      'Age': int.tryParse(ageController.text),
      'Height': int.tryParse(heightController.text),
      'Weight': int.tryParse(weightController.text),
    };

    print(data);

    try {
      // Encode the JSON data
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        // Request was successful, handle the response data
        Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          this.responseData = responseData[
              'message']; // Assuming the API response has a field called 'message'
        });
        print('Response: ${response.body}');
      } else {
        // Request failed with an error status code, handle the error
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      // Error occurred during the HTTP request, handle the exception
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataKlinisProvider = Provider.of<DataKlinisProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 35)),
                    Center(
                      child: Text(
                        "HALAMAN DIAGNOSA",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 35)),
                    Text("Heart Rate"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: heartRate,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text("IR"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: ir,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text("RED"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: red,
                      ),
                    ),
                    Text("Diastolic"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: diastolic,
                      ),
                    ),
                    Text("Gula Darah"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: glucose,
                      ),
                    ),
                    Text("SPO2"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: spo2,
                      ),
                    ),
                    Text("Systolic"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: systolic,
                      ),
                    ),
                    Text("Suhu tubuh"),
                    TextFormField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: bodyTemperature,
                      ),
                    ),
                    DropdownButtonFormField<int>(
                      value: selectedGender,
                      items: genderOptions.map((String gender) {
                        int value = genderOptions.indexOf(gender);
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedGender = newValue ?? 0;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Gender",
                      ),
                    ),
                    TextField(
                      controller: namaController,
                      decoration: InputDecoration(hintText: "Nama"),
                    ),
                    TextField(
                      controller: indexMasaTubuhController,
                      decoration: InputDecoration(hintText: "Index Masa Tubuh"),
                    ),
                    TextField(
                      controller: heightController,
                      decoration: InputDecoration(hintText: "Height"),
                    ),
                    TextField(
                      controller: weightController,
                      decoration: InputDecoration(hintText: "Weight"),
                    ),
                    TextField(
                      controller: ageController,
                      decoration: InputDecoration(hintText: "Age"),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text("Status : $responseData"),
                    Text("Kadar Gula Darah : $responseDataGulaDarah"),
                    ElevatedButton(
                      onPressed: () {
                        if (user != null) {
                          postDataDeteksi(
                            heartRate,
                            diastolic,
                            glucose,
                            spo2,
                            bodyTemperature,
                            systolic,
                          );
                          postDataKadarGula(heartRate, ir, red, spo2);
                          print("Get Diagnosa");
                        } else {
                          print('User is null');
                        }
                      },
                      child: Text('Cek'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print(
                              "Nilai Gula Darah : ${responseDataGulaDarah.toString()}");
                          DataKlinis dataklinis = DataKlinis(
                            user!.uid.toString(),
                            namaController.text,
                            int.tryParse(ageController.text) ?? 0,
                            selectedGender,
                            int.tryParse(heartRate) ?? 0,
                            int.tryParse(systolic) ?? 0,
                            int.tryParse(diastolic) ?? 0,
                            responseDataGulaDarah.toString(),
                            responseData,
                            int.tryParse(bodyTemperature) ?? 0,
                            int.tryParse(spo2) ?? 0,
                            int.tryParse(heightController.text) ?? 0,
                            int.tryParse(weightController.text) ?? 0,
                            int.tryParse(indexMasaTubuhController.text) ?? 0,
                            Timestamp.now(),
                          );
                          dataKlinisProvider.createDataKlinis(dataklinis);
                        },
                        child: Text("Simpan Diagnosa"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
