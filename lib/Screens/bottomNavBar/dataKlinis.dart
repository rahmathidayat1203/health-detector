// import 'package:aplikasi_health_detector_rev1/Provider/db/data_klinis_provider.dart';
// import 'package:aplikasi_health_detector_rev1/Utils/message.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';

// class DataKlinisScreen extends StatefulWidget {
//   const DataKlinisScreen({Key? key}) : super(key: key);

//   @override
//   State<DataKlinisScreen> createState() => _DataKlinisScreenState();
// }

// class _DataKlinisScreenState extends State<DataKlinisScreen> {
//   TextEditingController namaController = TextEditingController();
//   TextEditingController umurController = TextEditingController();
//   TextEditingController jeniskelaminController = TextEditingController();
//   TextEditingController tinggibadanController = TextEditingController();
//   TextEditingController beratbadanController = TextEditingController();
//   TextEditingController indeksmasatubuhController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final dataKlinisProvider = Provider.of<DataKlinisProvider>(context);

//     return Scaffold(
//       body: ListView(
//         children: [
//           Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 90.0, left: 20.0),
//               ),
//               Image.asset(
//                 "assets/images/logo.png",
//                 width: 80.0,
//               ),
//             ],
//           ),
//           Container(
//             padding: EdgeInsets.all(50.0),
//             child: Form(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     enabled: false,
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Color.fromARGB(218, 3, 23, 125),
//                         hintText: "Masukkan Data Klinis",
//                         hintStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 255, 255, 255)),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0))),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 50),
//                   ),
//                   TextFormField(
//                     controller: namaController,
//                     decoration: InputDecoration(
//                         hintText: "Nama",
//                         filled: true,
//                         fillColor: Color.fromARGB(255, 255, 255, 255),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50.0))),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   TextFormField(
//                     controller: umurController,
//                     decoration: InputDecoration(
//                         hintText: "Umur",
//                         filled: true,
//                         fillColor: Color.fromARGB(255, 255, 255, 255),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50.0))),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   TextFormField(
//                     controller: jeniskelaminController,
//                     decoration: InputDecoration(
//                         hintText: "Jenis Kelamin",
//                         filled: true,
//                         fillColor: Color.fromARGB(255, 255, 255, 255),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50.0))),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   TextFormField(
//                     controller: tinggibadanController,
//                     decoration: InputDecoration(
//                         hintText: "Tinggi Badan",
//                         filled: true,
//                         fillColor: Color.fromARGB(255, 255, 255, 255),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50.0))),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   TextFormField(
//                     controller: beratbadanController,
//                     decoration: InputDecoration(
//                         hintText: "Berat Badan",
//                         filled: true,
//                         fillColor: Color.fromARGB(255, 255, 255, 255),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50.0))),
//                   ),
//                   Padding(padding: EdgeInsets.only(top: 20.0)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: ElevatedButton.icon(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color.fromARGB(255, 234, 173, 50),
//                           ),
//                           onPressed: () {
//                             String currentTime =
//                                 DateFormat('yyyy-MM-dd HH:mm:ss')
//                                     .format(DateTime.now());

//                             try {
//                               dataKlinisProvider.createDataKlinis({
//                                 "nama": namaController.text,
//                                 "umur": umurController.text,
//                                 "jenis_kelamin": jeniskelaminController.text,
//                                 "tinggi_badan": tinggibadanController.text,
//                                 "berat_badan": beratbadanController.text,
//                                 "index_masa_tubuh":
//                                     indeksmasatubuhController.text,
//                                 'created_at': currentTime,
//                                 'updated_at': null
//                               });

//                               success(context,
//                                   message: "Hooray Data Berhasil DitambahKan");
//                             } catch (e) {
//                               errorMessage(context,
//                                   message:
//                                       "Oops Terdapat Kesalahan Dalam Memproses Data");
//                             }
//                           },
//                           icon: const FaIcon(FontAwesomeIcons.arrowRight),
//                           label: const Text(
//                             "SUBMIT",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
