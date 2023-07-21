import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/spo2_admin.dart';
import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/suhu_admin.dart';
import 'package:aplikasi_health_detector_rev1/Screens/bottomNavBar/syastolik_admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/db/data_klinis_provider.dart';
import 'gula_darah_admin.dart';
import 'hear_rate_admin.dart';

class LihatDataKlinisScreen extends StatelessWidget {
  const LihatDataKlinisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataklinisprovider = Provider.of<DataKlinisProvider>(context);
    return Scaffold(
      body: Center(
        child: Consumer<DataKlinisProvider>(
          builder: (context, provider, _) {
            if (provider.dataklinis.isEmpty) {
              return Text('No data available');
            } else {
              return ListView.builder(
                itemCount: provider.dataklinis.length,
                itemBuilder: (context, index) {
                  final user = provider.dataklinis[index];
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text("Nama : " + user['nama']),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jenis Kelamin: " +
                              (user["jenisKelamin"] == 0
                                  ? "Perempuan"
                                  : "Laki-laki")),
                          Text("Umur : " +
                              user["umur"].toString()), // Convert to String
                          Text("Tinggi Badan : " +
                              user["tinggibadanController"]
                                  .toString()), // Convert to String
                          Text("Index Masa Tubuh : " +
                              user["indeksmasatubuhController"]
                                  .toString()), 
                          Row(
                            children: [
                              SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HeartRateGraphAdmin(
                                            uid: user['uid'],
                                          )));
                            },
                            child: Icon(Icons.data_array),
                          ),
                          ),
                          
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GulaDarahAdmin(
                                            uid: user['uid'],
                                          )));
                            },
                            child: Icon(Icons.data_array),
                          ),
                          ),SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SPO2PAGEADMIN(
                                            uid: user['uid'],
                                          )));
                            },
                            child: Icon(Icons.data_array),
                          ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuhuTubuhGrafAdmin(
                                            uid: user['uid'],
                                          )));
                            },
                            child: Icon(Icons.data_array),
                          ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SystolikGrafAdmin(
                                            uid: user['uid'],
                                          )));
                            },
                            child: Icon(Icons.data_array),
                          ),
                          ),
                          
                            ],
                          )// Convert to String
                        ],
                      ),
                      
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataklinisprovider.fetchDataKlinis();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
