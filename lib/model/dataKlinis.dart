import 'package:cloud_firestore/cloud_firestore.dart';

class DataKlinis {
  String uid = "";
  String nama = "";
  int umur = 0;
  int jenisKelamin = 0;
  int heartrate = 0;
  int systolic = 0;
  int diastolic = 0;
  String gula_darah = "";
  String status_kesehatan = "";
  int suhu_tubuh = 0;
  int spo2 = 0;
  int tinggibadanController = 0;
  int beratbadanController = 0;
  int indeksmasatubuhController = 0;
  Timestamp timestamp;

  DataKlinis(
    this.uid,
    this.nama,
    this.umur,
    this.jenisKelamin,
    this.heartrate,
    this.systolic,
    this.diastolic,
    this.gula_darah,
    this.status_kesehatan,
    this.suhu_tubuh,
    this.spo2,
    this.tinggibadanController,
    this.beratbadanController,
    this.indeksmasatubuhController,
    this.timestamp,
  );

  // Convert DataKlinis object to a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nama': nama,
      'umur': umur,
      'jenisKelamin': jenisKelamin,
      'heartrate': heartrate,
      'systolic': systolic,
      'diastolic': diastolic,
      'gula_darah': gula_darah,
      'status_kesehatan': status_kesehatan,
      'suhu_tubuh': suhu_tubuh,
      'spo2': spo2,
      'tinggibadanController': tinggibadanController,
      'beratbadanController': beratbadanController,
      'indeksmasatubuhController': indeksmasatubuhController,
      'timestamp': timestamp,
    };
  }
}
