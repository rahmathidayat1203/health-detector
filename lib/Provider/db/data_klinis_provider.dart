import 'package:aplikasi_health_detector_rev1/model/dataKlinis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DataKlinisProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference dataKlinisRef =
      FirebaseFirestore.instance.collection('dataKlinis');
  List<Map<String, dynamic>> dataklinis = [];

  Future<void> createDataKlinis(DataKlinis data) async {
    Map<String, dynamic> dataMap = data.toMap();
    print(dataMap);
    try {
      await dataKlinisRef.add(dataMap);
      print('Data berhasil ditambahkan ke Cloud Firestore');
    } catch (error) {
      print('Terjadi kesalahan saat menambahkan data: $error');
    }
  }

  Future<void> editDataKlinis(
      String documentId, Map<String, dynamic> newData) async {
    try {
      await firestore.collection('dataKlinis').doc(documentId).update(newData);
      print('Data berhasil diubah di Cloud Firestore');
    } catch (error) {
      print('Terjadi kesalahan saat mengubah data: $error');
    }
  }

  Future<void> deleteDataKlinis(String documentId) async {
    try {
      await firestore.collection('dataKlinis').doc(documentId).delete();
      notifyListeners();
    } catch (error) {
      print('Error while deleting data with error: $error');
    }
  }

  Future<void> fetchDataKlinis() async {
    try {
      QuerySnapshot snapshot = await firestore.collection("dataKlinis").get();
      dataklinis = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic?>)
          .toList();

      print(dataklinis);
      notifyListeners();
    } catch (e) {
      print("Error while fetching data with error: ${e}");
    }
  }
}
